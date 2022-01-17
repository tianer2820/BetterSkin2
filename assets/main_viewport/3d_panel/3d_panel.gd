extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var poses = $"ViewportRenderer/3DViewport/3DWorld".get_pose_list()
	var pose_choice = $"HBox/3DOverlay/VBox/PoseOption"
	
	for pose in poses:
		pose_choice.add_item(pose)


func _on_PoseOption_item_selected(index: int) -> void:
	var pose_choice = $"HBox/3DOverlay/VBox/PoseOption"
	var pose = pose_choice.get_item_text(index)
	var poses = $"ViewportRenderer/3DViewport/3DWorld".set_pose(pose)
