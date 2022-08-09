extends ToolBase


"""
The dropper tool
"""

var _is_down = false


func _init() -> void:
	name = "Dropper"
	icon = load("res://scripts/tools/dropper_icon.png")
	
	self.add_prop("radius", int_prop(1, 1, 64, 1))

func activate(active: bool):
	pass
func pen_down(uv: Vector2):
	_is_down = true
	_do_pick_color(uv)
func pen_up(uv: Vector2):
	_is_down = false
func pen_move(uv: Vector2):
	if _is_down:
		_do_pick_color(uv)

func _do_pick_color(uv: Vector2):
	var render = DocumentManager.rendered_skin
	if render == null:
		return
	render.lock()
	var color = render.get_pixelv(uv)
	render.unlock()
	ToolManager.set_prime_color(color)
