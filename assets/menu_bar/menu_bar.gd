extends HBoxContainer





func _ready() -> void:
	var file_menu = $FileButton.get_popup()
	file_menu.connect("id_pressed", self, "_on_file_menu_id_pressed")
	file_menu.add_item("New", CST.MainMenuID.FILE_NEW, KEY_MASK_CMD | KEY_N)
	file_menu.add_item("Open", CST.MainMenuID.FILE_OPEN, KEY_MASK_CMD | KEY_O)
	file_menu.add_item("Save", CST.MainMenuID.FILE_SAVE, KEY_MASK_CMD | KEY_S)
	file_menu.add_item("Save As...", CST.MainMenuID.FILE_SAVEAS, KEY_MASK_CMD | KEY_MASK_SHIFT | KEY_S)
	file_menu.add_separator()
	file_menu.add_item("Import", CST.MainMenuID.FILE_IMPORT)
	file_menu.add_item("Export", CST.MainMenuID.FILE_EXPORT)
	
	var edit_menu = $EditButton.get_popup()
	edit_menu.connect("id_pressed", self, "_on_edit_menu_id_pressed")
	edit_menu.add_item("Undo", CST.MainMenuID.UNDO, KEY_MASK_CMD | KEY_Z)
	edit_menu.add_item("Redo", CST.MainMenuID.REDO, KEY_MASK_CMD | KEY_MASK_SHIFT | KEY_Z)
	
	var select_menu = $SelectButton.get_popup()
	select_menu.connect("id_pressed", self, "_on_select_menu_id_pressed")
	select_menu.add_item("Select All", CST.MainMenuID.SEL_ALL, KEY_MASK_CMD | KEY_A)
	select_menu.add_item("Select None", CST.MainMenuID.SEL_ALL, KEY_MASK_CMD | KEY_MASK_SHIFT | KEY_A)
	
	var layer_menu = $LayerButton.get_popup()
	layer_menu.connect("id_pressed", self, "_on_layer_menu_id_pressed")
	layer_menu.add_item("Option")
	
	var tools_menu = $ToolsButton.get_popup()
	tools_menu.connect("id_pressed", self, "_on_tools_menu_id_pressed")
	tools_menu.add_item("Option")
	
	var settings_menu = $SettingsButton.get_popup()
	settings_menu.connect("id_pressed", self, "_on_settings_menu_id_pressed")
	settings_menu.add_item("Preferences", CST.MainMenuID.OPEN_PREFERENCE)
	
	var help_menu = $HelpButton.get_popup()
	help_menu.connect("id_pressed", self, "_on_help_menu_id_pressed")
	help_menu.add_item("Option")
	

func _on_file_menu_id_pressed(id: int):
	match id:
		CST.MainMenuID.FILE_NEW:
			# new
			DocumentManager.ask_create_new_skin()
			pass
		CST.MainMenuID.FILE_OPEN:
			# open
			DocumentManager.ask_open_skin()
			pass
		CST.MainMenuID.FILE_SAVE:
			# save
			DocumentManager.ask_save_skin()
			pass
		CST.MainMenuID.FILE_SAVEAS:
			# save
			DocumentManager.ask_save_skin(true)
			pass
		CST.MainMenuID.FILE_IMPORT:
			# import a file as a layer
			DocumentManager.ask_import()
		CST.MainMenuID.FILE_EXPORT:
			DocumentManager.ask_export()

func _on_edit_menu_id_pressed(id: int):
	match id:
		CST.MainMenuID.UNDO:
			# undo
			pass
		CST.MainMenuID.REDO:
			# redo
			pass


func _on_select_menu_id_pressed(id: int):
	pass
	
func _on_layer_menu_id_pressed(id: int):
	pass

func _on_tools_menu_id_pressed(id: int):
	pass

func _on_settings_menu_id_pressed(id: int):
	match id:
		CST.MainMenuID.OPEN_PREFERENCE:
			SettingsManager.open_preferences()

func _on_help_menu_id_pressed(id: int):
	pass
