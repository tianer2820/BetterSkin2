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
				if event.control:
					_pick_color()
				else:
					ToolManager.pen_down(get_local_mouse_position())
			else:
				ToolManager.pen_up(get_local_mouse_position())

	elif event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and event.control:
				_pick_color()
		else:
			ToolManager.pen_move(get_local_mouse_position())

func _pick_color():
	var pos = get_local_mouse_position()
	var img = DocumentManager.rendered_skin
	img.lock()
	var color = img.get_pixelv(pos)
	img.unlock()
	ToolManager.set_prime_color(color)
