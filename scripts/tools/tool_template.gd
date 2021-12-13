extends ToolBase


"""
This is a simple tool template you can copy from to create new tools
"""


func _init() -> void:
	name = "Displayed Tool Name"
	icon = load("path/to/your/icon")
	
	tool_type = "unique_tool_identifier"
	tool_is_builtin = true
	
	tool_props = {
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
func pen_move(uc: Vector2):
	assert(false, "unimplemented")


# save to dict
func to_dict() -> Dictionary:
	return {}
# load from dict
func load_dict(dict):
	pass

# create a deep copy of this instance
func duplicate():
	var new_tool = load("the/script/file/of/this/class").new()
	new_tool.copy(self)
	return new_tool
