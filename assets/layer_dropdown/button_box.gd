extends HBoxContainer



func _ready() -> void:
	pass



func _on_ButtonAdd_pressed() -> void:
	var current_layer = DocumentManager.active_layer
	var new_size: Vector2
	if current_layer != null:
		new_size = current_layer.image.get_size()
	else:
		var res = DocumentManager.active_skin.resolution
		new_size = Vector2(res, res)
	var new_layer = SkinLayer.new("new layer", new_size)
	DocumentManager.add_layer(new_layer, DocumentManager.active_layer_index + 1)
	

func _on_ButtonDup_pressed() -> void:
	var dup_layer: SkinLayer = DocumentManager.active_layer.duplicate()
	dup_layer.name += ".dup"
	DocumentManager.add_layer(dup_layer,
			DocumentManager.active_layer_index + 1)


func _on_ButtonUp_pressed() -> void:
	var active_idx = DocumentManager.active_layer_index
	var layer_num = DocumentManager.layers.size()
	if active_idx >= layer_num - 1:
		return
	var layer = DocumentManager.pop_layer(active_idx)
	DocumentManager.add_layer(layer, active_idx + 1)
	DocumentManager.active_layer_index = active_idx + 1


func _on_ButtonDown_pressed() -> void:
	var active_idx = DocumentManager.active_layer_index
	if active_idx <= 0:
		return
	var layer = DocumentManager.pop_layer(active_idx)
	DocumentManager.add_layer(layer, active_idx - 1)
	DocumentManager.active_layer_index = active_idx - 1


func _on_ButtonDelete_pressed() -> void:
	DocumentManager.pop_layer(DocumentManager.active_layer_index)
