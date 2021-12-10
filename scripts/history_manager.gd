extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_operation():
	pass
	
func undo():
	pass
func redo():
	pass


class Operation:
	var name
	func undo():
		pass
	func redo():
		pass
