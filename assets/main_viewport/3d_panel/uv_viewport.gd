extends Viewport


var uv_mat = load("res://assets/main_viewport/3d_panel/uv_shadermaterial.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rig = $"Rig basic2"
	rig.material = uv_mat
