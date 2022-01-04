extends HBoxContainer

"""
This script provides the color picker interface
"""


var picker_color: Color setget _set_color


func _ready() -> void:
	ToolManager.connect("prime_color_changed", self, "_on_manager_color_change")
	_set_color(ToolManager.get_prime_color())

func _on_ColorCircle_pick_color(new_color) -> void:
	picker_color = new_color
	ToolManager.set_prime_color(picker_color)

func _on_VSlider_value_changed(value: float) -> void:
	picker_color.v = value / 100
	$AspectRatioContainer/ColorCircle.picker_color = picker_color
	ToolManager.set_prime_color(picker_color)
	
func _set_color(new_color: Color):
	picker_color = new_color
	$AspectRatioContainer/ColorCircle.picker_color = new_color
	$VSlider.value = new_color.v * 100

func _on_manager_color_change():
	_set_color(ToolManager.get_prime_color())
