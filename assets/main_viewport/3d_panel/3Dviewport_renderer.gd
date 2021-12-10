extends ViewportContainer

# handle moving and scalling, passing event into viewport

var is_dragging = false


func _gui_input(event: InputEvent) -> void:
	$"3DViewport".input(event)
	if not $"3DViewport".is_input_handled():
		$"3DViewport".unhandled_input(event)
	
	# press button
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == BUTTON_MIDDLE:
			# drag
			if event.pressed:
				is_dragging = true
				
			else:
				is_dragging = false
		elif event.button_index == BUTTON_WHEEL_UP:
			# scale up
			$"3DViewport/3DWorld".scale_camera(0.9)

		elif event.button_index == BUTTON_WHEEL_DOWN:
			# scale down
			$"3DViewport/3DWorld".scale_camera(1/0.9)
	
	# mouse motion
	elif event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if is_dragging:
			$"3DViewport/3DWorld".move_camera(-event.relative)
	
