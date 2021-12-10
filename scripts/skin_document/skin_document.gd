extends Reference
class_name SkinDocument


# the skin data class
# represent a skin project on disk,
# holds skin layers, file names, formats
# and color pattels.
# Rendering and modification are not handled
# rendering is done by SkinRenderer and by viewport


enum{
	TYPE_STEVE, TYPE_ALEX
}


var skin_type = TYPE_STEVE
var skin_resolution = 64

# to keep consistency with godot, lower layers
# will be rendered on top of upper ones.
# the display order can be reversed if needed
# by the UI
var _layers = []
var _active_layer_index = -1


func _init(type, resolution: int = 64) -> void:
	skin_type = type
	
	skin_resolution = resolution
	var new_layer = SkinLayer.new("Base",
			Vector2(resolution, resolution))
	_layers.append(new_layer)
	_active_layer_index = 0


func add_layer(layer: SkinLayer):
	assert(false, "unimplemented")

func remove_layer(layer: SkinLayer):
	assert(false, "unimplemented")

func move_layer(layer, target_index):
	assert(false, "unimplemented")

func get_layers() -> Array:
	return _layers.duplicate()

func get_active_layer() -> SkinLayer:
	return _layers[_active_layer_index]

