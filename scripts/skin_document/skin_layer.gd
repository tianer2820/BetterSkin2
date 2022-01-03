extends Reference
class_name SkinLayer


var name: String
var visible: bool
var alpha: float
var image: Image
var mode


enum{
	NORMAL,
}


func _init(name: String, size: Vector2) -> void:
	self.name = name
	visible = true
	alpha = 1.0
	image = Image.new()
	image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))
	mode = NORMAL

func copy_from(other):
	other = other as SkinLayer
	name = other.name
	visible = other.visible
	alpha = other.alpha
	image.copy_from(other.image)
	mode = other.mode

func duplicate():
	var skin_layer_class = load("res://scripts/skin_document/skin_layer.gd")
	var dup = skin_layer_class.new(name, image.get_size())
	dup.copy_from(self)
	return dup
