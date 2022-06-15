extends Tree


var root: TreeItem

var _icon_visible_on: Texture
var _icon_visible_off: Texture

func _ready() -> void:
	# Prepare Menu Items
	var menu = $LayersMenu
	menu.add_item("Rename", CST.TreeMenu.RENAME)
	menu.add_item("Duplicate", CST.TreeMenu.DUP)
	menu.add_item("Delete", CST.TreeMenu.DELETE)
	menu.add_item("Merge Down", CST.TreeMenu.MERGE_DOWN)
	
	#
	
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
	
	for layer in DocumentManager.layers:
		layer = layer as SkinLayer
		var item = self.create_item(root, 0)
		item.set_text(0, layer.name)
		item.set_icon(0, load("res://icon.png"))
		item.set_icon_max_width(0, 20)
		
		# icons
		var icon
		if layer.visible:
			icon = _icon_visible_on
		else:
			icon = _icon_visible_off
		
		item.add_button(0, _icon_visible_on, CST.TreeButton.VISIBEL)
		item.set_editable(0, true)
	_sync_active_layer()

func _sync_active_layer():
	var layer_idx = DocumentManager.active_layer_index
	var tree_idx = DocumentManager.layers.size() - 1 - layer_idx
	self._set_active(tree_idx)
	var blend = get_node("../BlendSlider") as HSlider
	blend.value = DocumentManager.active_layer.alpha*100


func _set_active(index: int):
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
			var idx = _get_item_index(item)
			var layer_idx = DocumentManager.layers.size() - 1 - idx
			var layer = DocumentManager.layers[layer_idx]
			
			var tex = item.get_button(column, id)
			if layer.visible:
				tex = _icon_visible_off
				layer.visible = false
			else:
				tex = _icon_visible_on
				layer.visible = true
			item.set_button(column, id, tex)
			DocumentManager.queue_render_skin()


func _on_Layers_item_selected() -> void:
	var item = get_selected()
	var index = _get_item_index(item)
	var layer_idx = DocumentManager.layers.size() - 1 - index
	DocumentManager.active_layer_index = layer_idx


func _on_Layers_item_edited() -> void:
	# rename layer
	var item = get_edited()
	var tree_idx = _get_item_index(item)
	var layer_idx = DocumentManager.layers.size() - 1 - tree_idx
	DocumentManager.rename_layer(layer_idx, item.get_text(0))


func _on_Layers_item_rmb_selected(position: Vector2) -> void:
	# popup menu
	var menu = $LayersMenu
	menu.rect_global_position = get_global_mouse_position()
	menu.set_as_minsize()
	menu.popup()

func _on_LayersMenu_id_pressed(id: int) -> void:
	match id:
		CST.TreeMenu.RENAME:
			edit_selected()
		CST.TreeMenu.DUP:
			var dup_layer: SkinLayer = DocumentManager.active_layer.duplicate()
			dup_layer.name += ".dup"
			DocumentManager.add_layer(dup_layer,
					DocumentManager.active_layer_index + 1)
		CST.TreeMenu.DELETE:
			DocumentManager.pop_layer(DocumentManager.active_layer_index)
		CST.TreeMenu.MERGE_DOWN:
			pass


func _on_BlendSlider_value_changed(value):
	DocumentManager.active_layer.alpha = get_node("../BlendSlider").value / 100
