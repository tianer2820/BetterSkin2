extends ToolBase


var _is_down = false

func _init() -> void:
	name = "Test Tool"
	icon = load("res://scripts/tools/test_tool_icon.png")
	
	self.add_prop("test_int", int_prop(3, 0, 6, 1))
	self.add_prop("test_float", float_prop(1.234, -2, 2))
	self.add_prop("test_tip", brush_tip_prop(BrushTip.new()))
	self.add_prop("test_bool", bool_prop(false))
	self.add_prop("test_choice", choice_prop(0, ['aaa', 'bbb', 'ccc']))
	
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
