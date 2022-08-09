extends ToolBase


var _is_down = false

func _init() -> void:
	name = "Pixel Pen"
	icon = load("res://scripts/tools/pixel_pen_icon.tres")
	
	tool_type = "pixel_pen"
	tool_is_builtin = true
	
	displayed_props = {
		"brush_tip": brush_tip_prop(BrushTip.new()),
		"strength": float_prop(1, 0, 1),
		"accumulate": bool_prop(false),
		"mode": choice_prop(0, ['normal', 'add', 'multiply']),
	}
	
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






func to_dict() -> Dictionary:
	return {}

func load_dict(dict):
	pass

func duplicate():
	var new_tool = load("res://scripts/tools/pixel_pen.gd").new()
	new_tool.copy(self)
	return new_tool
	
