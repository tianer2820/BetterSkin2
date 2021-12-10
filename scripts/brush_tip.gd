extends Reference
class_name BrushTip


var size: int = 1
var shape = SQUARE
var smooth_ramp
var strength

enum{
	SQUARE, ROUND
}


class SmoothRamp:
	func get_mode_string():
		pass
	func get_weight(distance):
		pass
		
	func get_prarm_list():
		pass
	func set_param(param, value):
		pass
	
	enum{
		CONSTANT, LINEAR
	}
