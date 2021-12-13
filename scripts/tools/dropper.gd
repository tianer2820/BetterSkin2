extends ToolBase


"""
The dropper tool
"""

var _is_down = false


func _init() -> void:
	name = "Dropper"
	icon = load("res://scripts/tools/dropper_icon.png")
	
	tool_type = "dropper"
	tool_is_builtin = true
	
	tool_props = {
		"radius": int_prop(1, 1, 64, 1),
	}

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


# save to dict
func to_dict() -> Dictionary:
	return {"radius": get_prop("radius")}
# load from dict
func load_dict(dict):
	if "radius" in dict:
		set_prop("radius", dict["radius"])


# create a deep copy of this instance
func duplicate():
	var new_tool = load("the/script/file/of/this/class").new()
	new_tool.copy(self)
	return new_tool
