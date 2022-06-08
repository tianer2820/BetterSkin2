extends PanelContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_ButtonNew_pressed():
	DocumentManager.ask_create_new_skin()
	pass # Replace with function body.


func _on_ButtonOpen_pressed():
	DocumentManager.ask_open_skin()
	pass # Replace with function body.


func _on_ButtonSave_pressed():
	DocumentManager.ask_save_skin()
	pass # Replace with function body.
