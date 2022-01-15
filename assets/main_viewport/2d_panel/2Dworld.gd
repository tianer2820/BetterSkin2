extends Node2D

# signals for viewport menu
signal open_bg_menu
signal open_ref_menu


onready var camera = $Camera2D


func _ready() -> void:
	DocumentManager.connect("skin_rerendered", self, "_refresh_render")
	DocumentManager.connect("skin_changed", self, "_reload_skin")
	self._reload_skin()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == BUTTON_RIGHT:
			# popup menu
			get_tree().set_input_as_handled()
			emit_signal("open_bg_menu")



func move_camera(delta: Vector2):
	camera.position += delta * camera.zoom.x

func scale_camera(factor: float):
	camera.zoom *= factor
	self._update_overlay_scale()

func reset_camera():
	camera.position = Vector2(0, 0)
	camera.zoom = Vector2(0.2, 0.2)
	self._update_overlay_scale()


func _refresh_render():
	var new_texture = ImageTexture.new()
	new_texture.create_from_image(DocumentManager.rendered_skin, 0)
	$"2DSkinRect".texture = new_texture
	
func _reload_skin():
	var overlay = $Overlay
	# clear old overlay
	for child in overlay.get_children():
		child.queue_free()
	var new_skin = DocumentManager.active_skin
	for region in new_skin.regions:
		region = region as SkinRegion
		# add text
		var label = Label.new()
		label.text = region.name
		label.rect_position = region.rect.position
		overlay.add_child(label)
		# add line
		var line = Line2D.new()
		var points = PoolVector2Array()
		var rect = region.rect
		points.append(rect.position)
		points.append(Vector2(rect.position.x + rect.size.x, rect.position.y))
		points.append(rect.position + rect.size)
		points.append(Vector2(rect.position.x, rect.position.y + rect.size.y))
		points.append(rect.position)
		line.points = points
		line.position = Vector2(0, 0)
		line.default_color = Color(1, 1, 1, 1)
		overlay.add_child(line)
	# set scale
	self._update_overlay_scale()
	
func _update_overlay_scale():
	var overlay = $Overlay
	var trans = get_canvas_transform()
	var new_scale = trans.affine_inverse().get_scale()
	for child in overlay.get_children():
		if child is Line2D:
			child = child as Line2D
			child.width = 2 * new_scale.x
		elif child is Label:
			child = child as Label
			child.rect_scale = 1 * new_scale
		else:
			pass



# ref images
func show_all_ref():
	assert(false, "unimplemented")
func hide_all_ref():
	assert(false, "unimplemented")
func add_ref(image: Image, pos: Vector2):
	assert(false, "unimplemented")
