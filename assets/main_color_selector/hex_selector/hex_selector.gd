extends HBoxContainer



var picker_color: Color setget _set_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ToolManager.connect("prime_color_changed", self, "_on_manager_color_change")
	_set_color(ToolManager.get_prime_color())


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
	ToolManager.set_prime_color(picker_color)


func _regulate_text():
	$LineEdit.text = picker_color.to_html(false)


func _on_manager_color_change():
	_set_color(ToolManager.get_prime_color())
