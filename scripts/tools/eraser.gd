extends ToolBase


"""
eraser tool
"""
var is_pressed = false


func _init() -> void:
	name = "Eraser"
	icon = load("res://scripts/tools/eraser.png")
	
	tool_type = "eraser"
	tool_is_builtin = true
	
	displayed_props = {
		"brush_tip": brush_tip_prop(BrushTip.new()),
	}

# called once when tool is selected
func activate(active: bool):
	is_pressed = false

# called when mouse down
func pen_down(uv: Vector2):
	is_pressed = true
	_erase_pixel(uv)

# called when mouse release
func pen_up(uv: Vector2):
	is_pressed = false
	_erase_pixel(uv)
	DocumentManager.apply_draw_buffer()
	DocumentManager.queue_render_skin()

# called when mouse move, even if not pressed
func pen_move(uv: Vector2):
	if is_pressed:
		_erase_pixel(uv)


# create a deep copy of this instance
func duplicate():
	var new_tool = load("the/script/file/of/this/class").new()
	new_tool.copy(self)
	return new_tool


func _erase_pixel(uv):
	var layer = DocumentManager.draw_buffer_layer
	var img = layer.image
	img.lock()
	img.set_pixelv(uv, Color(0, 0, 0, 0))
	img.unlock()
	DocumentManager.queue_render_skin()
