extends HBoxContainer

signal add_ref
signal show_all_ref
signal hide_all_ref
signal change_display_mode(new_mode)

func _on_ButtonAddRef_pressed() -> void:
	emit_signal("add_ref")


func _on_ButtonShowAllRef_pressed() -> void:
	emit_signal("show_all_ref")


func _on_ButtonHideAllRef_pressed() -> void:
	emit_signal("hide_all_ref")


func _on_OptionButton_item_selected(index: int) -> void:
	var mode
	match index:
		0:
			mode = "both"
		1:
			mode = "2d"
		2:
			mode = "3d"
	emit_signal("change_display_mode", mode)
