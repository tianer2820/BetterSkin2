extends PanelContainer


signal pick_color(new_color)

var picker_color: Color setget _set_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_color(Color(1, 1, 1))


# Set the color without triggering the color_selected signal
func _set_color(new_color: Color) -> void:
	picker_color = new_color
	_update_child_color()


# child pickers
func _on_CircleSelector_pick_color(new_color) -> void:
	picker_color = new_color
	_update_child_color()
	emit_signal("pick_color", new_color)

func _on_HexSelector_pick_color(new_color) -> void:
	picker_color = new_color
	_update_child_color()
	emit_signal("pick_color", new_color)


func _on_RGB_pick_color(new_color) -> void:
	picker_color = new_color
	_update_child_color()
	emit_signal("pick_color", new_color)



func _update_child_color():
	$VBoxContainer/ColorRect.color = picker_color
	$VBoxContainer/CircleSelector.picker_color = picker_color
	$VBoxContainer/HexSelector.picker_color = picker_color
	$VBoxContainer/ColorSelector/RGB.picker_color = picker_color

