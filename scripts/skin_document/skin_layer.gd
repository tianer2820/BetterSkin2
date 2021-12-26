extends Reference
class_name SkinLayer


var name: String
var visible: bool
var alpha: float
var image: Image


func _init(name: String, size: Vector2) -> void:
	self.name = name
	visible = true
	alpha = 1.0
	image = Image.new()
	image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))


func duplicate():
	var skin_layer_class = load("res://scripts/skin_document/skin_layer.gd")
	var dup = skin_layer_class.new(name, image.get_size())
	dup.alpha = alpha
	dup.image.copy_from(image)
	return dup
