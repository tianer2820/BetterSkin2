extends Tree


var root: TreeItem

var _icon_visible_on: Texture
var _icon_visible_off: Texture

func _ready() -> void:
	root = create_item()
	self.hide_root = true
	
	_icon_visible_on = load("res://assets/layer_dropdown/icon_visible_on.tres")
	_icon_visible_off = load("res://assets/layer_dropdown/icon_visible_off.tres")
	
	DocumentManager.connect("layers_changed", self, "_on_layers_change")
	DocumentManager.connect("active_layer_changed", self, "_on_active_layer_change")
	
	_sync_layers()

func _sync_layers():
	root.free()
	root = create_item()
	
	for layer in DocumentManager.active_skin.layers:
		layer = layer as SkinLayer
		var item = self.create_item(root, 0)
		item.set_text(0, layer.name)
		item.set_icon(0, load("res://icon.png"))
		item.set_icon_max_width(0, 20)
		
		item.add_button(0, _icon_visible_on, CST.TreeButton.VISIBEL)
		item.set_editable(0, true)
	_sync_active_layer()

func _sync_active_layer():
	var layer_idx = DocumentManager.active_layer_index
	var tree_idx = DocumentManager.active_skin.layers.size() - 1 - layer_idx
	self._set_active(tree_idx)


func _set_active(index: int):
	print("set")
	var current: TreeItem = root.get_children()
	while current != null:
		if index == 0:
			if not current.is_selected(0):
				current.select(0)
			break
		current = current.get_next()
		index -= 1
		

func _get_item_index(item: TreeItem) -> int:
	var current: TreeItem = root.get_children()
	var index = -1
	while current != null:
		index += 1
		if current == item:
			return index
		current = current.get_next()
	return -1


# Document signals

func _on_layers_change():
	_sync_layers()
func _on_active_layer_change():
	_sync_active_layer()

# user inputs

func _on_Layers_button_pressed(item: TreeItem, column: int, id: int) -> void:
	match id:
		CST.TreeButton.VISIBEL:
			var tex = item.get_button(column, id)
			if tex == _icon_visible_on:
				tex = _icon_visible_off
				# set layer visible off
			else:
				tex = _icon_visible_on
				# set layer visible on
			item.set_button(column, id, tex)
			print("pressed on: {0}".format([_get_item_index(item)]))


func _on_Layers_item_selected() -> void:
	var item = get_selected()
	var index = _get_item_index(item)
	var layer_idx = DocumentManager.active_skin.layers.size() - 1 - index
	DocumentManager.active_layer_index = layer_idx


func _on_Layers_item_edited() -> void:
	# rename layer
	var item = get_edited()
	var tree_idx = _get_item_index(item)
	var layer_idx = DocumentManager.active_skin.layers.size() - 1 - tree_idx
	DocumentManager.rename_layer(layer_idx, item.get_text(0))
