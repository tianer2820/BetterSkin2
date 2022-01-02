extends Viewport


var uv_mat = load("res://assets/main_viewport/3d_panel/uv_shadermaterial.tres")
var model = load("res://assets/main_viewport/3d_panel/model/Rig basic.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rig = $"Rig basic2"
	for child in rig.get_children():
		for mesh in child.get_children():
			mesh = mesh as MeshInstance
			mesh.material_override = uv_mat
