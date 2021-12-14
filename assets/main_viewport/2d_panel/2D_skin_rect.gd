extends TextureRect


"""
display rendered skin
detect mouse input and call tool manager
"""

func _ready() -> void:
	pass


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				ToolManager.pen_down(get_local_mouse_position())
			else:
				ToolManager.pen_up(get_local_mouse_position())

	elif event is InputEventMouseMotion:
		ToolManager.pen_move(get_local_mouse_position())

