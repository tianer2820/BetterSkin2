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


func set_part_visibility(part_id, visibility):
	match part_id:
		CST.BodyPartID.HEAD:
			$Armature/Skeleton/Head.visible = visibility
		CST.BodyPartID.BODY:
			$Armature/Skeleton/Body.visible = visibility
		CST.BodyPartID.ARM_L:
			$"Armature/Skeleton/Arm L".visible = visibility
		CST.BodyPartID.ARM_R:
			$"Armature/Skeleton/Arm R".visible = visibility
		CST.BodyPartID.LEG_L:
			$"Armature/Skeleton/Leg L".visible = visibility
		CST.BodyPartID.LEG_R:
			$"Armature/Skeleton/Leg R".visible = visibility
		
		CST.BodyPartID.HEAD2:
			$Armature/Skeleton/Hat.visible = visibility
		CST.BodyPartID.BODY2:
			$"Armature/Skeleton/Second Body".visible = visibility
		CST.BodyPartID.ARM_L2:
			$"Armature/Skeleton/Second Arm L".visible = visibility
		CST.BodyPartID.ARM_R2:
			$"Armature/Skeleton/Second Arm R".visible = visibility
		CST.BodyPartID.LEG_L2:
			$"Armature/Skeleton/Second Leg L".visible = visibility
		CST.BodyPartID.LEG_R2:
			$"Armature/Skeleton/Second Leg R".visible = visibility
