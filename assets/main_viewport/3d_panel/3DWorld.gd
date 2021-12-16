extends Spatial


var _camera_facing = 0
var _camera_pitch = 0

onready var _cam_root = $CameraRoot
onready var _camera = $CameraRoot/Camera

var material = preload("res://assets/main_viewport/3d_panel/model/Skin.material")

func _ready() -> void:
	DocumentManager.connect("skin_rerendered", self, "_refresh_render")



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
	var new_fov = _camera.fov * factor
	new_fov = clamp(new_fov, 20, 90)
	_camera.fov = new_fov
	pass


func _refresh_render():
#	var mat = $Ground.get_surface_material(0) as SpatialMaterial
	var mat = material
	
	var tex = ImageTexture.new()
	tex.create_from_image(DocumentManager.rendered_skin, 0)
	mat.albedo_texture = tex
