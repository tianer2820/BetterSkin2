extends TextureRect




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var trans = get_canvas_transform()
	var new_scale = trans.affine_inverse().get_scale()
	for child in get_children():
		child.rect_scale = new_scale
