extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var poses = $"ViewportRenderer/3DViewport/3DWorld".get_pose_list()
	var pose_choice = $"HBox/3DOverlay/VBox/PoseOption"
	
	for pose in poses:
		pose_choice.add_item(pose)


# set position
func _on_PoseOption_item_selected(index: int) -> void:
	var pose_choice = $"HBox/3DOverlay/VBox/PoseOption"
	var pose = pose_choice.get_item_text(index)
	$"ViewportRenderer/3DViewport/3DWorld".set_pose(pose)


# set part visibility
# first layer
func _on_BodyPanel_visibility_toggle(part_id, visiblity) -> void:
	$"ViewportRenderer/3DViewport/3DWorld".set_part_visibility(part_id, visiblity)

func _on_BodyPanel2_visibility_toggle(part_id, visiblity) -> void:
	$"ViewportRenderer/3DViewport/3DWorld".set_part_visibility(part_id + CST.BodyPartID.HEAD2, visiblity)

func _on_GridCheckbox_toggled(button_pressed):
	$"ViewportRenderer/3DViewport/3DWorld".toggle_grid(button_pressed)
