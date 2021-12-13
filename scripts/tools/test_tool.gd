extends ToolBase


func _init() -> void:
	name = "Test Tool"
	icon = load("res://scripts/tools/test_tool_icon.png")
	
	tool_type = "test_tool"
	tool_is_builtin = true
	
	tool_props = {
		"test_int": int_prop(3, 0, 6, 1),
		"test_float": float_prop(1.234, -2, 2, 0.3),
	}
	
func duplicate():
	var new_tool = load("res://scripts/tools/test_tool.gd").new()
	new_tool.copy(self)
	return new_tool


# draw related, must override
func activate(active: bool):
	pass
func pen_down(uv: Vector2):
	_draw_pixel(uv)
func pen_up(uv: Vector2):
	pass
func pen_move(uv: Vector2):
	_draw_pixel(uv)

func _draw_pixel(uv):
	var layer = DocumentManager.get_draw_layer()
	var img = layer.image
	img.lock()
	img.set_pixelv(uv, ToolManager.get_prime_color())
	img.unlock()
	DocumentManager.queue_render_skin()
