extends ToolBase


func _init() -> void:
	name = "Pixel Pen"
	icon = load("res://scripts/tools/pixel_pen_icon.tres")
	
	tool_type = "pixel_pen"
	tool_is_builtin = true
	
	displayed_props = {
		"brush_tip": brush_tip_prop(BrushTip.new()),
	}
	
	
func activate(active: bool):
	pass
func pen_down(uv: Vector2):
	pass
func pen_up(uv: Vector2):
	pass
func pen_move(uc: Vector2):
	pass

func to_dict() -> Dictionary:
	return {}

func load_dict(dict):
	pass

func duplicate():
	var new_tool = load("res://scripts/tools/pixel_pen.gd").new()
	new_tool.copy(self)
	return new_tool
	
