extends Reference
class_name SkinLayer


var name: String
var alpha: float
var image: Image


func _init(name: String, size: Vector2) -> void:
	self.name = name
	alpha = 1.0
	image = Image.new()
	image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 0, 0))
