extends Spatial


var _camera_facing = 0
var _camera_pitch = 0

onready var _cam_root = $CameraRoot

func _ready() -> void:
	DocumentManager.connect("document_render_changed", self, "_update_render")



func move_camera(delta: Vector2):
	_camera_facing += delta.x / 3
	_camera_pitch += delta.y / 3
	_camera_pitch = clamp(_camera_pitch, -90, 90)

	
	var trans = Basis(Vector3(1, 0, 0),
			_camera_pitch / 180 * PI)
	trans = trans.rotated(Vector3(0, 1, 0),
			_camera_facing / 180 * PI)
	trans = trans.scaled(_cam_root.transform.basis.get_scale())
	_cam_root.transform.basis = trans


func scale_camera(factor: float):
#	camera.zoom *= factor
	pass


func _update_render():
	var mat = $MeshInstance.get_surface_material(0) as SpatialMaterial
	
	var tex = ImageTexture.new()
	tex.create_from_image(DocumentManager.rendered_skin, 0)
	mat.albedo_texture = tex
