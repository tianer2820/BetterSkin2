extends Node


static func render_skin_export(skin: SkinDocument) -> Image:
	var layers = skin.layers
	var resolution = skin.resolution
	var final_img = Image.new()
	final_img.create(resolution, resolution, false, Image.FORMAT_RGBA8)
	final_img.fill(Color(1, 1, 1, 0))
	
	for layer in layers:
		if not layer.visible:
			continue
		var img: Image = Image.new()
		img.copy_from(layer.image)
		_multiply_alpha(img, layer.alpha)
		var new_img = _pixel_resize(img,
				Vector2(resolution, resolution))		
		final_img.blend_rect(new_img,
				Rect2(0, 0, resolution, resolution),
				Vector2(0, 0))
	return final_img

static func render_skin_preview() -> Image:
	var skin = DocumentManager.active_skin
	var active_layer = DocumentManager.active_layer_index
	var draw_buffer = DocumentManager.draw_buffer_layer
	var tool_indecator = DocumentManager.tool_indecator_layer
	
	var layers = skin.layers
	var resolution = skin.resolution
	var final_img = Image.new()
	final_img.create(resolution, resolution, false, Image.FORMAT_RGBA8)
	final_img.fill(Color(1, 1, 1, 0))
	
	for i in range(layers.size()):
		var layer = layers[i]
		if not layer.visible:
			continue

		var new_img: Image = Image.new()
		if i == active_layer:
			# add paint buffer layer
			new_img.copy_from(draw_buffer.image)
#			new_img = _pixel_resize(draw_buffer.image,
#					Vector2(resolution, resolution))
		else:
			new_img.copy_from(layer.image)
		
		# apply the layer alpha blend value
		_multiply_alpha(new_img, layer.alpha)
		# resize to render size
		new_img = _pixel_resize(new_img, Vector2(resolution, resolution))
			
		final_img.blend_rect(new_img,
				Rect2(0, 0, resolution, resolution),
				Vector2(0, 0))
	
	# add tool indecator layer
	var new_img = _pixel_resize(tool_indecator.image,
			Vector2(resolution, resolution))
	final_img.blend_rect(new_img,
			Rect2(0, 0, resolution, resolution),
			Vector2(0, 0))
	return final_img

# merge upper layer to lower layer, lower layer is modified in place
static func merge_layers(upper: SkinLayer, lower: SkinLayer):
	var size: Vector2 = lower.image.get_size()
	var overlay = _pixel_resize(upper.image, size)
	lower.image.blend_rect(overlay,
			Rect2(0, 0, size.x, size.y),
			Vector2(0, 0))

static func _pixel_resize(img: Image, target_size: Vector2) -> Image:
	var new_img = Image.new()
	var size = img.get_size()
	new_img.create(size.x, size.y,
			false, Image.FORMAT_RGBA8)
	new_img.copy_from(img)
	new_img.resize(target_size.x, target_size.y,
			Image.INTERPOLATE_NEAREST)
	return new_img

# edit the image inplace, multiply the entire alpha channel
static func _multiply_alpha(img: Image, alpha: float):
	var w = img.get_width()
	var h = img.get_height()
	img.lock()
	for y in range(h):
		for x in range(w):
			var pixel_col = img.get_pixel(x, y)
			pixel_col.a *= alpha
			img.set_pixel(x, y, pixel_col)
	img.unlock()

