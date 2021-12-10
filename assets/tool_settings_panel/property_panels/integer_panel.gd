extends PropPanelBase


func set_name(new_name: String):
	$Label.text = new_name.capitalize()

func set_prop(prop: ToolProp):
	$SpinBox.min_value = prop.value_min
	$SpinBox.max_value = prop.value_max
	$SpinBox.step = prop.value_step

func set_value(value):
	$SpinBox.value = value

func get_value():
	return $SpinBox.value


func _on_SpinBox_value_changed(value: float) -> void:
	emit_signal("value_changed")
