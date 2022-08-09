extends ToolBase


var _is_down = false

func _init() -> void:
	name = "Pixel Pen"
	icon = load("res://scripts/tools/pixel_pen_icon.tres")
	
	self.add_prop("brush_tip", brush_tip_prop(BrushTip.new()))
	self.add_prop("strength", float_prop(1, 0, 1))
	self.add_prop("accumulate", bool_prop(false))
	self.add_prop("mode", choice_prop(0, ['normal', 'add', 'multiply']))


func activate(active: bool):
	pass

func pen_down(uv: Vector2):
	_is_down = true
	var layer = DocumentManager.draw_buffer_layer
	var img = layer.image
	_draw_pixel(img, uv)

func pen_up(uv: Vector2):
	_is_down = false
	DocumentManager.apply_draw_buffer()
	DocumentManager.queue_render_skin()

func pen_move(uv: Vector2):
	var tool_indicate_layer = DocumentManager.tool_indicate_layer.image
	var img_size = tool_indicate_layer.get_size()
	var img_rect = Rect2(0, 0, img_size.x, img_size.y)
	
	if img_rect.has_point(uv):
		tool_indicate_layer.fill(Color(0, 0, 0, 0))
		_draw_pixel(tool_indicate_layer, uv)
		DocumentManager.queue_render_skin()
	
	if _is_down:
		var layer = DocumentManager.draw_buffer_layer
		var img = layer.image
		_draw_pixel(img, uv)

func _draw_pixel(img: Image, uv: Vector2):
	var img_size = img.get_size()
	var img_rect = Rect2(0, 0, img_size.x, img_size.y)
	
	if img_rect.has_point(uv):
		
		# get brush tip size and offset uv point
		var tip: BrushTip = self.get_prop('brush_tip')
		var size: int = tip.size
		var offset = int(size / 2)
		uv.x -= offset
		uv.y -= offset
		
		img.lock()
		for x in range(size):
			for y in range(size):
				var point = uv
				point.x += x
				point.y += y
				if img_rect.has_point(point):
					img.set_pixelv(point, ToolManager.get_prime_color())
		img.unlock()
		DocumentManager.queue_render_skin()
