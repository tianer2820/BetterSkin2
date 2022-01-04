extends VBoxContainer



var picker_color: Color setget _set_color


func _ready() -> void:
	ToolManager.connect("prime_color_changed", self, "_on_manager_color_change")
	_set_color(ToolManager.get_prime_color())

# Set the color without triggering the color_selected signal
func _set_color(new_color: Color) -> void:
	picker_color = new_color
	_update_slider()

func _update_slider():
	$RSlider.value = picker_color.r * 100
	$GSlider.value = picker_color.g * 100
	$BSlider.value = picker_color.b * 100


func _on_RSlider_value_changed(value: float) -> void:
	picker_color.r = value / 100
	ToolManager.set_prime_color(picker_color)

func _on_GSlider_value_changed(value: float) -> void:
	picker_color.g = value / 100
	ToolManager.set_prime_color(picker_color)

func _on_BSlider_value_changed(value: float) -> void:
	picker_color.b = value / 100
	ToolManager.set_prime_color(picker_color)


func _on_manager_color_change():
	_set_color(ToolManager.get_prime_color())
