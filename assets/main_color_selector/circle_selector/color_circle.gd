extends ColorRect


signal pick_color(new_color)


export var cursor_ratio: float = 0.1


var picker_color: Color setget _set_picker_color

var _mouse_pressed = false


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.pressed and event.button_index == BUTTON_LEFT:
			var size = rect_size
			var pos = get_local_mouse_position()
			pos.x /= size.x
			pos.y /= size.y
			if (pos - Vector2(0.5, 0.5)).length() < 0.5:
				# pick color
				emit_signal("pick_color", _pick_color())
				_mouse_pressed = true
			
		else:
			_mouse_pressed = false
	elif event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if _mouse_pressed:
			# pick color
			emit_signal("pick_color", _pick_color())
			

# pick the color under mouse pointer
func _pick_color():
	var size = rect_size
	var pos = get_local_mouse_position()
	var x = pos.x / size.x - 0.5
	var y = pos.y / size.y - 0.5
	
	var h = fposmod(atan2(-y, x) / TAU , 1)
	var s = clamp(sqrt(pow(x, 2) + pow(y, 2)) * 2, 0, 1)
	var v = picker_color.v
	
	picker_color = Color.from_hsv(h, s, v)
	
	_update_cursor()
	return picker_color

# relocate and rescale the picker cursor
func _update_cursor():
	# update size
	$Cursor.rect_size = rect_size * cursor_ratio
	
	# update position
	var vec_from_center = Vector2(picker_color.s / 2, 0)
	vec_from_center = vec_from_center.rotated(picker_color.h * TAU)
	vec_from_center.y *= -1
	
	if vec_from_center.length() > 0.5:
		vec_from_center = vec_from_center.normalized() * 0.5
	vec_from_center.x *= rect_size.x
	vec_from_center.y *= rect_size.y
	$Cursor.rect_position = vec_from_center + rect_size / 2 - $Cursor.rect_size / 2


func _set_picker_color(new_color):
	picker_color = new_color
	_update_cursor()
	var mat = material as ShaderMaterial
	mat.set_shader_param("value", new_color.v)


func _on_ColorCircle_item_rect_changed() -> void:
	_update_cursor()

func _on_ColorCircle_resized() -> void:
	_update_cursor()
