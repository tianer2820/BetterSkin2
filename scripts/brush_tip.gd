extends Reference
class_name BrushTip


var size: int = 1
var shape = SQUARE
var smooth_ramp
var strength: float = 1.0

enum{
	SQUARE, ROUND
}

func to_dict() -> Dictionary:
	return {
		'type': 'brush_tip',
		'size': size,
		'shape': shape,
		'ramp': 0,
		'strength': strength,
	}
func load_dict(dict: Dictionary):
	size = dict['size']
	shape = dict['shape']
	strength = dict['strength']

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
