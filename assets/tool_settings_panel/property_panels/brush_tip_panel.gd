extends PropPanelBase


func set_name(new_name: String):
	$Label.text = new_name

func set_prop(prop: ToolProp):
	self.set_value(prop.value_default)

func set_value(value: BrushTip):
	if $SpinBox.value != value.size:
		$SpinBox.value = value.size
	
	match value.shape:
		BrushTip.ROUND:
			$OptionButton.selected = 1
		BrushTip.SQUARE:
			$OptionButton.selected = 0
		_:
			$OptionButton.selected = 0

func get_value():
	var tip = BrushTip.new()
	tip.size = $SpinBox.value
	match $OptionButton.selected:
		1:
			tip.shape = BrushTip.ROUND
		0:
			tip.shape = BrushTip.SQUARE
		_:
			tip.shape = BrushTip.SQUARE
	return tip


func _on_SpinBox_value_changed(value):
	emit_signal("value_changed")

func _on_OptionButton_item_selected(index):
	emit_signal("value_changed")
