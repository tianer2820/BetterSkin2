extends ToolBase


var _is_down = false

func _init() -> void:
	name = "Test Tool"
	icon = load("res://scripts/tools/test_tool_icon.png")
	
	tool_type = "test_tool"
	tool_is_builtin = true
	
	displayed_props = {
		"test_int": int_prop(3, 0, 6, 1),
		"test_float": float_prop(1.234, -2, 2),
		"test_tip": brush_tip_prop(BrushTip.new()),
		"test_bool": bool_prop(false),
		"test_choice": choice_prop(0, ['aaa', 'bbb', 'ccc']),
	}
	
func duplicate():
	var new_tool = load("res://scripts/tools/test_tool.gd").new()
	new_tool.copy(self)
	return new_tool


# draw related, must override
func activate(active: bool):
	pass
func pen_down(uv: Vector2):
	_is_down = true
	_draw_pixel(uv)
	
func pen_up(uv: Vector2):
	_is_down = false
	DocumentManager.apply_draw_buffer()
	DocumentManager.queue_render_skin()

func pen_move(uv: Vector2):
	if _is_down:
		_draw_pixel(uv)

func _draw_pixel(uv):
	var layer = DocumentManager.draw_buffer_layer
	var img = layer.image
	
	var img_size = img.get_size()
	var img_rect = Rect2(0, 0, img_size.x, img_size.y)
	
	if img_rect.has_point(uv):
		img.lock()
		img.set_pixelv(uv, ToolManager.get_prime_color())
		img.unlock()
		DocumentManager.queue_render_skin()
