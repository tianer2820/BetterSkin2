extends ColorRect



var picker_color: Color setget _set_color


func _ready() -> void:
	ToolManager.connect("prime_color_changed", self, "_on_manager_color_change")
	_set_color(ToolManager.get_prime_color())

func _set_color(new_color: Color):
	self.color = new_color

func _on_manager_color_change():
	_set_color(ToolManager.get_prime_color())
