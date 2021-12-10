extends HBoxContainer

signal pick_color(new_color)


var picker_color: Color setget _set_color


func _set_color(new_color: Color):
	picker_color = new_color
	$AspectRatioContainer/ColorCircle.picker_color = new_color
	$VSlider.value = new_color.v * 100


func _on_ColorCircle_pick_color(new_color) -> void:
	picker_color = new_color
	emit_signal("pick_color", new_color)


func _on_VSlider_value_changed(value: float) -> void:
	picker_color.v = value / 100
	$AspectRatioContainer/ColorCircle.picker_color = picker_color
	emit_signal("pick_color", picker_color)

