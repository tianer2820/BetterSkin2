extends Spatial


var material setget _set_material, _get_material
onready var _skeleton = $"Armature/Skeleton/"


func _ready() -> void:
	material = _skeleton.get_child(0).mesh.surface_get_material(0)
	set_pose('StandPose')


func _set_material(mat: Material):
	for child in _skeleton.get_children():
		if child is MeshInstance:
			child = child as MeshInstance
			child.material_override = mat
	material = mat


func _get_material() -> Material:
	return material


func get_pose_list() -> Array:
	return $AnimationPlayer.get_animation_list()

func set_pose(pose: String):
	$AnimationPlayer.play(pose)
