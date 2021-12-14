extends HBoxContainer





func _ready() -> void:
	$FileButton.get_popup().connect("id_pressed", self, "_on_file_menu_id_pressed")


func _on_edit_menu_id_pressed(id: int):
	match id:
		0:
			# new
			pass
		1:
			# open
			pass
		2:
			# save
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
