extends PanelContainer


var _is_min = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# position adjustment

func _on_ButtonLeft_pressed() -> void:
	self.get_parent().move_child(self, 0)


func _on_ButtonRight_pressed() -> void:
	self.get_parent().move_child(self, 1)


func _on_ButtonMin_pressed() -> void:
	_is_min = not _is_min
	if _is_min:
		$VBox/HButtonBox/ButtonMin.text = "+"
	else:
		$VBox/HButtonBox/ButtonMin.text = "-"
	for	child in $VBox.get_children():
		child = child as Control
		if child.name != "HButtonBox":
			if _is_min:
				child.hide()
			else:
				child.show()
		



