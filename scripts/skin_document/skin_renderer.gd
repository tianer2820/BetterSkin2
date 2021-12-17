extends Node


static func render_skin_export(skin: SkinDocument) -> Image:
	var layers = skin.layers
	var resolution = skin.resolution
	var final_img = Image.new()
	final_img.create(resolution, resolution, false, Image.FORMAT_RGBA8)
	final_img.fill(Color(1, 1, 1, 0))
	
	for layer in layers:
		var img = layer.image as Image
		var size = img.get_size()
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
		var img = layer.image as Image
		var new_img = _pixel_resize(img, Vector2(resolution, resolution))
		final_img.blend_rect(new_img,
				Rect2(0, 0, resolution, resolution),
				Vector2(0, 0))
		
		if i == active_layer:
			# time to add buffer layer
			new_img = _pixel_resize(draw_buffer.image,
					Vector2(resolution, resolution))
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


static func _pixel_resize(img: Image, target_size: Vector2) -> Image:
	var new_img = Image.new()
	var size = new_img.get_size()
	new_img.create(size.x, size.y,
			false, Image.FORMAT_RGBA8)
	new_img.copy_from(img)
	new_img.resize(target_size.x, target_size.y,
			Image.INTERPOLATE_NEAREST)
	return new_img
