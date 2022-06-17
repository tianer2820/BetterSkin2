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

static func create_skin(type, json: String):
	var skin_document_class = load("res://scripts/skin_document/skin_document.gd") as GDScript
	var skin = skin_document_class.new(type, 64)
	
	# load regions data from json
	var file = File.new()
	file.open(json, File.READ)
	var text = file.get_as_text()
	var p = JSON.parse(text)
	if typeof(p.result) != TYPE_ARRAY:
		push_error("Unexpected json parse results.")
	# set region values
	for obj in p.result:
		var region: SkinRegion = SkinRegion.new()
		region.name = obj["name"]
		var rect = obj["rect"]
		region.rect = Rect2(rect[0], rect[1], rect[2], rect[3])
		skin.regions.append(region)

	return skin

static func create_steve():
	return create_skin(TYPE_STEVE, "res://scripts/skin_document/region_formats/steve.json")


static func create_alex():
	return create_skin(TYPE_ALEX, "res://scripts/skin_document/region_formats/alex.json")
