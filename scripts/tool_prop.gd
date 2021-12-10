extends Reference
class_name ToolProp

enum{
	INTEGER, FLOAT, BRUSH_TIP, BOOL, CHOICE
}

var value_default

var prop_type = INTEGER

# properties for int and float
var value_min = 0
var value_max = 0
var value_step = 0

# properties for choice
var choices = []

