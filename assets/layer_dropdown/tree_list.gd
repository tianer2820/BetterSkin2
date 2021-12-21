extends Tree


var tree: Tree
var root: TreeItem

var _icon_visible_on: Texture
var _icon_visible_off: Texture

func _ready() -> void:
	tree = self
	root = tree.create_item()
	tree.hide_root = true
	
	_icon_visible_on = load("res://assets/layer_dropdown/icon_visible_on.tres")
	_icon_visible_off = load("res://assets/layer_dropdown/icon_visible_off.tres")
	
	_sync_layers()

func _sync_layers():
	for i in range(10):
		var item = tree.create_item(root)
		item.set_text(0, "layer {0}".format([i]))
		item.set_icon(0, load("res://icon.png"))
		item.set_icon_max_width(0, 20)
		
		item.add_button(0, _icon_visible_on, CST.TreeButton.VISIBEL)
		
		item.set_editable(0, true)
		

func _get_item_index(item: TreeItem) -> int:
	var current: TreeItem = root.get_children()
	var index = -1
	while current != null:
		index += 1
		if current == item:
			return index
		current = current.get_next()
	return -1



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
	# set active layer
	pass # Replace with function body.


func _on_Layers_item_edited() -> void:
	# rename layer
	var item = get_edited()
	var but_id = get_pressed_button()
	
	pass # Replace with function body.
