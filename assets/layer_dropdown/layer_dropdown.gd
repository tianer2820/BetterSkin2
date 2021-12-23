extends OptionButton


func _ready() -> void:
	DocumentManager.connect("layers_changed", self, "_skin_layers_changed")
	DocumentManager.connect("active_layer_changed", self, "_skin_active_layer_changed")
	
	_reload_layers()


func _reload_layers():
	self.clear()
	var layers = DocumentManager.layers
	for i in range(layers.size()):
		var index = layers.size() - i - 1 # reverse order
		var layer = layers[index]
		self.add_item(layer.name, index)
	_update_active_layer()

func _update_active_layer():
	var active_index = DocumentManager.active_layer_index
	var item_index = self.get_item_count() - 1 - active_index
	self.select(item_index)


# signal connects
func _skin_layers_changed():
	_reload_layers()
func _skin_active_layer_changed():
	_update_active_layer()

func _on_LayersDropdown_item_selected(index: int) -> void:
	var id = self.get_item_id(index)
	DocumentManager.active_layer_index = id


func _on_RightClickButton_pressed() -> void:
	var panel = $LayerEditorPanel
	panel.set_as_minsize()
	var mouse = get_global_mouse_position()
	var size = panel.rect_size
	var pos = mouse
	pos.x -= size.x
	panel.set_global_position(pos)
	panel.popup()
	
