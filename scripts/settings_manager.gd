extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func open_preferences():
	get_node(CST.PREFERENCE_DIALOG).popup()
