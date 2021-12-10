extends Control



func _on_BackgroundMenu_id_pressed(id: int) -> void:
	match id:
		0:
			# add reference
			pass
		1:
			# reset canvas
			$"ViewportRenderer/2DViewport/2DWorld".reset_camera()
		2:
			pass
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
