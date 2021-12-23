extends HBoxContainer



func _ready() -> void:
	pass



func _on_ButtonAdd_pressed() -> void:
	pass # Replace with function body.


func _on_ButtonDup_pressed() -> void:
	pass # Replace with function body.


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
	pass # Replace with function body.
