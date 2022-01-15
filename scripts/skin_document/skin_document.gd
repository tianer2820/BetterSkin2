extends Reference
class_name SkinDocument

"""
the skin data class

holds skin layers, file name, formats.
Just a data class, rendering and modification are done by SkinRenderer and document manager

Tools should not modify this directly. All modificatioin should be done through DocumentManager
"""

enum{
	TYPE_STEVE, TYPE_ALEX
}


var skin_type = TYPE_STEVE
var resolution = 64

"""lower layers will be rendered on top of upper ones.
UI should display it in the reverse order"""
var layers: Array = []

# regions to be displayed
var regions: Array = []

func _init(type, res: int = 64) -> void:
	skin_type = type
	
	resolution = res
	var new_layer = SkinLayer.new("Base",
			Vector2(resolution, resolution))
	layers.append(new_layer)


"""
static functions for creating new instance
"""

static func create_steve():
	var skin = SkinDocument.new(TYPE_STEVE, 64)
	return skin
	
static func create_alex():
	var skin = SkinDocument.new(TYPE_ALEX, 64)
	return skin
