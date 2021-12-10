extends Node2D


onready var camera = $Camera2D


func _ready() -> void:
	DocumentManager.connect("document_render_changed", self, "_update_render")


func move_camera(delta: Vector2):
	camera.position += delta * camera.zoom.x


func scale_camera(factor: float):
	camera.zoom *= factor


func _update_render():
	var new_texture = ImageTexture.new()
	new_texture.create_from_image(DocumentManager.rendered_skin, 0)
	$"2DSkinRect".texture = new_texture
