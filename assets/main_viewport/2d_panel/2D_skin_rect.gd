extends TextureRect


var pressed = false
var _last_dot: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				# pressed
				pressed = true
				_draw_dot(false)
			else:
				# released
				pressed = false
	
	elif event is InputEventMouseMotion:
		event = event as InputEventMouseButton
		if pressed:
			# continue draw
			_draw_dot(true)


func _draw_dot(link: bool):
	var pos = get_local_mouse_position()
	var img = DocumentManager.active_document.get_layers()[0].image
	img.lock()
	if link:
		var line = pos - _last_dot
		if abs(line.x) > abs(line.y):
			# flat
			for x in range(int(abs(line.x)) + 1):
				var re_x = x * sign(line.x)
				var y = 1 / line.aspect() * re_x
				img.set_pixel(_last_dot.x + re_x,
						_last_dot.y + y, Color(0, 0, 0))
		else:
			# steep
			for y in range(int(abs(line.y)) + 1):
				var re_y = y * sign(line.y)
				var x = line.aspect() * re_y
				img.set_pixel(_last_dot.x + x,
						_last_dot.y + re_y, Color(0, 0, 0))
	else:
		img.set_pixel(pos.x, pos.y, Color(0, 0, 0))
	img.unlock()

#	texture = ImageTexture.new()
#	texture.create_from_image(img, 0)
	
	_last_dot = pos
	
	DocumentManager._document_modified()
