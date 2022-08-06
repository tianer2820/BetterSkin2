extends PropPanelBase




func set_name(new_name: String):
	$Label.text = new_name.capitalize()

func set_prop(prop: ToolProp):
	$HSlider.min_value = prop.value_min
	$HSlider.max_value = prop.value_max
	
func set_value(value):
	if not $HSlider.value == value:
		$HSlider.value = value
	$Label2.text = '%.3f' % value

func get_value():
	return $HSlider.value


func _on_HSlider_value_changed(value):
	self.set_value(value)
	self.emit_signal("value_changed")


func _ask_enter_value():
	$HSlider/LineEdit.text = str(self.get_value())
	$HSlider/LineEdit.show()
	$HSlider/LineEdit.grab_focus()
	$HSlider/LineEdit.select_all()

func _finish_enter_value():
	$HSlider/LineEdit.hide()
	var value = float($HSlider/LineEdit.text)
	self.set_value(value)
	self.emit_signal("value_changed")	

func _on_LineEdit_text_entered(new_text):
	self._finish_enter_value()
func _on_LineEdit_focus_exited():
	self._finish_enter_value()



func _on_HSlider_gui_input(event):
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.pressed == false and event.button_index == 2:
			self._ask_enter_value()


func _on_Label2_gui_input(event):
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.pressed == false:
			self._ask_enter_value()
