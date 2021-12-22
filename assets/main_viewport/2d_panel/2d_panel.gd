extends Control

func _ready() -> void:
	var bg_menu = $BackgroundMenu
	bg_menu.clear()
	bg_menu.add_item('Add Reference', CST.BGMenuID.ADD_REF)
	bg_menu.add_item('Reset Canvas', CST.BGMenuID.RESET_CANVAS)


func _on_BackgroundMenu_id_pressed(id: int) -> void:
	match id:
		CST.BGMenuID.ADD_REF:
			# add reference
			pass
		CST.BGMenuID.RESET_CANVAS:
			# reset canvas
			$"ViewportRenderer/2DViewport/2DWorld".reset_camera()
		_:
			pass


func _on_2DWorld_open_bg_menu() -> void:
	$BackgroundMenu.set_global_position(get_global_mouse_position())
	$BackgroundMenu.set_as_minsize()
	$BackgroundMenu.popup()


# ref images
func show_all_ref():
	$"ViewportRenderer/2DViewport/2DWorld".show_all_ref()
func hide_all_ref():
	$"ViewportRenderer/2DViewport/2DWorld".hide_all_ref()
func add_ref(image: Image, pos: Vector2):
	$"ViewportRenderer/2DViewport/2DWorld".add_ref(image, pos)
