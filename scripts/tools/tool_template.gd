extends ToolBase


"""
This is a simple tool template you can copy from to create new tools
"""


func _init() -> void:
	name = "Displayed Tool Name"
	icon = load("path/to/your/icon")
		
	displayed_props = {
		"some_int": int_prop(0, 0, 100, 1),
		"some_brush_tip": brush_tip_prop(BrushTip.new()),
	}

# called once when tool is selected
func activate(active: bool):
	assert(false, "unimplemented")

# called when mouse down
func pen_down(uv: Vector2):
	assert(false, "unimplemented")

# called when mouse release
func pen_up(uv: Vector2):
	assert(false, "unimplemented")

# called when mouse move, even if not pressed
func pen_move(uv: Vector2):
	assert(false, "unimplemented")

