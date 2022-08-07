extends Reference
class_name BrushTip


var size: int = 1
var shape = SQUARE

enum{
	SQUARE, ROUND
}

func to_dict() -> Dictionary:
	return {
		'type': 'brush_tip',
		'size': size,
		'shape': shape,
	}
func load_dict(dict: Dictionary):
	size = dict['size']
	shape = dict['shape']
