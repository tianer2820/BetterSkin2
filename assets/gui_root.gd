extends PanelContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ToolManager.connect("prime_color_changed",
			self, "_on_manager_color_changed")



func _on_ColorSelector_pick_color(new_color) -> void:
	ToolManager.set_prime_color(new_color)

func _on_manager_color_changed():
	$VBox/MainSplit/SettingsSplit/ColorSelector.picker_color = ToolManager.get_prime_color()
