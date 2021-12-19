extends HBoxContainer





func _ready() -> void:
	var file_menu = $FileButton.get_popup()
	file_menu.connect("id_pressed", self, "_on_file_menu_id_pressed")
	file_menu.add_item("New", CST.Action.FILE_NEW, KEY_MASK_CMD | KEY_N)
	file_menu.add_item("Open", CST.Action.FILE_OPEN, KEY_MASK_CMD | KEY_O)
	file_menu.add_item("Save", CST.Action.FILE_SAVE, KEY_MASK_CMD | KEY_S)
	
	var edit_menu = $EditButton.get_popup()
	edit_menu.connect("id_pressed", self, "_on_edit_menu_id_pressed")
	edit_menu.add_item("Undo", CST.Action.UNDO, KEY_MASK_CMD | KEY_Z)
	edit_menu.add_item("Redo", CST.Action.REDO, KEY_MASK_CMD | KEY_MASK_SHIFT | KEY_Z)
	
	var select_menu = $SelectButton.get_popup()
	select_menu.connect("id_pressed", self, "_on_select_menu_id_pressed")
	select_menu.add_item("Select All", CST.Action.SEL_ALL, KEY_MASK_CMD | KEY_A)
	select_menu.add_item("Select None", CST.Action.SEL_ALL, KEY_MASK_CMD | KEY_MASK_SHIFT | KEY_A)
	
	var layer_menu = $LayerButton.get_popup()
	layer_menu.connect("id_pressed", self, "_on_layer_menu_id_pressed")
	layer_menu.add_item("Option")
	
	var tools_menu = $ToolsButton.get_popup()
	tools_menu.connect("id_pressed", self, "_on_tools_menu_id_pressed")
	tools_menu.add_item("Option")
	
	var settings_menu = $SettingsButton.get_popup()
	settings_menu.connect("id_pressed", self, "_on_settings_menu_id_pressed")
	settings_menu.add_item("Option")
	
	var help_menu = $HelpButton.get_popup()
	help_menu.connect("id_pressed", self, "_on_help_menu_id_pressed")
	help_menu.add_item("Option")
	

func _on_file_menu_id_pressed(id: int):
	match id:
		CST.Action.FILE_NEW:
			# new
			pass
		CST.Action.FILE_OPEN:
			# open
			pass
		CST.Action.FILE_SAVE:
			# save
			pass

func _on_edit_menu_id_pressed(id: int):
	match id:
		CST.Action.UNDO:
			# undo
			pass
		CST.Action.REDO:
			# redo
			pass


func _on_select_menu_id_pressed(id: int):
	pass
	
func _on_layer_menu_id_pressed(id: int):
	pass

func _on_tools_menu_id_pressed(id: int):
	pass

func _on_settings_menu_id_pressed(id: int):
	pass

func _on_help_menu_id_pressed(id: int):
	pass
