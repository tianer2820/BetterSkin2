extends PopupPanel



var text_value: String = ""


func _ready() -> void:
	hide()

# use `var new_name = yield(prompt_rename("old"), "completed")`
# to get a new name or empty string if canceled by user.
func prompt_rename(old_name: String):
	var line_edit = $VBoxContainer/LineEdit
	line_edit.text = old_name
	line_edit.caret_position = old_name.length()
	line_edit.select_all()
	
	popup_centered()
	yield(self, "popup_hide")
	return text_value


func _on_LineEdit_text_entered(new_text: String) -> void:
	# confirmed
	text_value = new_text
	hide()

func _on_RenamePopup_about_to_show() -> void:
	# default canceled value
	text_value = ""
