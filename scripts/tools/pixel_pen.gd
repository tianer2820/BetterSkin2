extends ToolBase


func _init() -> void:
	name = "Pixel Pen"
	icon = load("res://scripts/tools/pixel_pen_icon.tres")
	
	tool_type = "pixel_pen"
	tool_labels = ['builtin']
	
	tool_props = {
		"brush_tip": brush_tip_prop(BrushTip.new()),
	}

func duplicate():
	var new_tool = load("res://scripts/tools/pixel_pen.gd").new()
	new_tool.copy(self)
	return new_tool
	
