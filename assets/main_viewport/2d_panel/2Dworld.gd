extends Node2D

# signals for viewport menu
signal open_bg_menu
signal open_ref_menu


onready var camera = $Camera2D


func _ready() -> void:
	DocumentManager.connect("document_rerendered", self, "_refresh_render")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == BUTTON_RIGHT:
			# popup menu
			get_tree().set_input_as_handled()
			emit_signal("open_bg_menu")



func move_camera(delta: Vector2):
	camera.position += delta * camera.zoom.x

func scale_camera(factor: float):
	camera.zoom *= factor

func reset_camera():
	camera.position = Vector2(0, 0)
	camera.zoom = Vector2(0.2, 0.2)


func _refresh_render():
	var new_texture = ImageTexture.new()
	new_texture.create_from_image(DocumentManager.rendered_skin, 0)
	$"2DSkinRect".texture = new_texture



# ref images
func show_all_ref():
	assert(false, "unimplemented")
func hide_all_ref():
	assert(false, "unimplemented")
func add_ref(image: Image, pos: Vector2):
	assert(false, "unimplemented")
