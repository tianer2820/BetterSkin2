extends Reference
class_name SkinDocument

"""
the skin data class

holds skin layers, file name, formats.
Just a data class, rendering and modification are done by SkinRenderer and document manager

Tools should not modify this directly. All modificatioin should be done through DocumentManager.
"""

enum{
	TYPE_STEVE, TYPE_ALEX
}


var skin_type = TYPE_STEVE
var skin_resolution = 64

"""lower layers will be rendered on top of upper ones.
UI should display it in the reverse order"""
var layers: Array = []


func _init(type, resolution: int = 64) -> void:
	skin_type = type
	
	skin_resolution = resolution
	var new_layer = SkinLayer.new("Base",
			Vector2(resolution, resolution))
	layers.append(new_layer)
