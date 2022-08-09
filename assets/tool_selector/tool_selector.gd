extends PanelContainer


onready var _item_list = $VBox/ItemList

var _tool_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ToolManager.connect("active_tool_changed",
			self, "_on_manager_active_tool_changed")
	ToolManager.connect("tool_list_changed",
			self, "_on_manager_tool_list_changed")
	ToolManager.connect("tool_modified",
			self, "_on_manager_tool_modified")
	
	_item_list.clear()
	_sync_tool_list()
	

func get_active_tool() -> ToolBase:
	var indexes = $VBox/ItemList.get_selected_items()
	if indexes.size() > 0:
		return _tool_list[indexes[0]]
	return null


# set the displayed active tool
func _select_tool(new_tool):
	var index = _tool_list.find(new_tool)
	_item_list.select(index)

# register a new tool to the panel
func _add_tool(new_tool):
	new_tool = new_tool as ToolBase
	assert(new_tool != null, "Invalid tool object")
	var tool_icon = new_tool.icon as Texture
	assert(tool_icon != null, "Invalid tool icon")
	var tool_name = new_tool.name
	
	_item_list.add_item(tool_name, tool_icon)
#	_item_list.add_icon_item(tool_icon)
	_tool_list.append(new_tool)

# remove a tool from panel
func _remove_tool(removed_tool):
	var index = _tool_list.find(removed_tool)
	if index != -1:
		_tool_list.remove(-1)
		_item_list.remove_item(index)

# sync tool list from manager
func _sync_tool_list():
	var new_tool_list = ToolManager.get_tool_list()

	_tool_list = []
	_item_list.clear()
	for tool_obj in new_tool_list:
		_add_tool(tool_obj)
	_select_tool(ToolManager.get_active_tool())



# User inputs

func _on_ItemList_item_selected(index: int) -> void:
	ToolManager.set_active_tool(_tool_list[index])

#func _on_ItemList_item_rmb_selected(index: int, at_position: Vector2) -> void:
#	var global_pos = get_global_mouse_position()
#	var active_tool = get_active_tool()
#	if active_tool.tool_is_builtin:
#		$VBox/ItemList/PopupMenu.set_item_disabled(1, true)
#		$VBox/ItemList/PopupMenu.set_item_disabled(2, true)
#	else:
#		$VBox/ItemList/PopupMenu.set_item_disabled(1, false)
#		$VBox/ItemList/PopupMenu.set_item_disabled(2, false)
#	$VBox/ItemList/PopupMenu.set_item_disabled(0, false)
#
#	$VBox/ItemList/PopupMenu.set_position(global_pos)
#	$VBox/ItemList/PopupMenu.popup()
	
	

func _on_ButtonScaleUp_pressed() -> void:
	var a = _item_list.fixed_icon_size.x
	a = move_toward(a, 60, 10)
	_item_list.fixed_icon_size = Vector2(a, a)
	_item_list.ensure_current_is_visible()

func _on_ButtonScaleDown_pressed() -> void:
	var a = _item_list.fixed_icon_size.x
	a = move_toward(a, 10, 10)
	_item_list.fixed_icon_size = Vector2(a, a)


#func _on_PopupMenu_id_pressed(id: int) -> void:
#	match id:
#		0:
#			# duplicate
#			var active_tool = get_active_tool()
#			var text = yield($VBox/ItemList/RenamePopup.prompt_rename(
#						active_tool.name), "completed")
#			if text != "":
#				# do duplicate
#				var dup_tool = active_tool.duplicate()
#				dup_tool.name = text
#				dup_tool.tool_is_builtin = false
#				ToolManager.add_tool(dup_tool)
#		1:
#			# delete
#			ToolManager.remove_tool(get_active_tool())
#		2:
#			# rename
#			var active_tool = get_active_tool()
#			var text = yield($VBox/ItemList/RenamePopup.prompt_rename(
#						active_tool.name), "completed")
#			if text != "":
#				active_tool.name = text
#				ToolManager.announce_tool_modified(active_tool)



# ToolManager signals

func _on_manager_tool_list_changed():
	_sync_tool_list()

func _on_manager_active_tool_changed():
	_select_tool(ToolManager.get_active_tool())

func _on_manager_tool_modified(modified_tool):
	_sync_tool_list()

