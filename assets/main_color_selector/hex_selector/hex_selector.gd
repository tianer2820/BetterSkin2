extends HBoxContainer


signal pick_color(new_color)

var picker_color: Color setget _set_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_color(Color(1, 1, 1))


# Set the color without triggering the color_selected signal
func _set_color(new_color: Color) -> void:
	picker_color = new_color
	_regulate_text()


func _on_LineEdit_text_changed(new_text: String) -> void:
	if not new_text.is_valid_hex_number():
		return
	if not new_text.length() == 6:
		return

	picker_color = Color(new_text)
	_regulate_text()
	emit_signal("pick_color", picker_color)


func _regulate_text():
	$LineEdit.text = picker_color.to_html(false)
