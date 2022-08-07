extends PropPanelBase



func set_name(new_name: String):
	$Label.text = new_name.capitalize()

func set_prop(prop: ToolProp):
	var button = $OptionButton
	button.clear()
	for item in prop.choices:
		button.add_item(item)
	button.selected = prop.value_default

func set_value(value):
	$OptionButton.selected = value

func get_value():
	return $OptionButton.selected

func _on_OptionButton_item_selected(index):
	emit_signal("value_changed")
