extends Spatial


var _camera_facing = 0
var _camera_pitch = 0

onready var _cam_root = $CameraRoot
onready var _camera = $CameraRoot/Camera

var material = preload("res://assets/main_viewport/3d_panel/grid_shadermaterial.tres")

func _ready() -> void:
	DocumentManager.connect("skin_rerendered", self, "_refresh_render")
	get_viewport().connect("size_changed", self, '_on_viewport_size_change')
	_sync_cam()
	
	$"Rig basic".material = material;


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		
		var pos = event.position
		var img = $UVViewport.get_texture().get_data()
		img.lock()
		var col = img.get_pixelv(pos)
		img.unlock()
		
		var uv
		if col.b != 0:
			uv = Vector2(col.r, col.g)
			uv *= DocumentManager.active_layer.image.get_size()
		else:
			uv = Vector2(-1, -1)
		
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				ToolManager.pen_down(uv)
			else:
				ToolManager.pen_up(uv)

	elif event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		var pos = event.position
		var img = $UVViewport.get_texture().get_data()
		img.lock()
		var col = img.get_pixelv(pos)
		img.unlock()
		
		if col.b != 0:
			var uv = Vector2(col.r, col.g)
			uv *= DocumentManager.active_layer.image.get_size()
			
			ToolManager.pen_move(uv)


func get_pose_list() -> Array:
	return $"Rig basic".get_pose_list()

func set_pose(pose: String):
	$"Rig basic".set_pose(pose)
	$"UVViewport/Rig basic2".set_pose(pose)


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
	
	_sync_cam()


func scale_camera(factor: float):
	var new_fov = _camera.fov * factor
	new_fov = clamp(new_fov, 20, 90)
	_camera.fov = new_fov
	
	_sync_cam()


func _sync_cam():
	var cam1 = $CameraRoot/Camera
	var cam2 = $UVViewport/Camera
	cam2.transform = cam1.global_transform
	cam2.fov = cam1.fov


func _refresh_render():
#	var mat = $Ground.get_surface_material(0) as SpatialMaterial
	var mat = material
	
	var tex = ImageTexture.new()
	tex.create_from_image(DocumentManager.rendered_skin, 0)
	mat.set_shader_param("tex", tex)


func _on_viewport_size_change():
	$UVViewport.size = get_viewport().size
