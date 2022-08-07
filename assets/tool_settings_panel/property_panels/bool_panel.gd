extends PropPanelBase


func set_name(new_name: String):
	$Label.text = new_name.capitalize()

func set_prop(prop: ToolProp):
	$CheckBox.pressed = prop.value_default

func set_value(value):
	$CheckBox.pressed = value

func get_value():
	return $CheckBox.pressed


func _on_CheckBox_toggled(button_pressed):
	emit_signal("value_changed")
