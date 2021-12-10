extends Node


static func render_skin_doc(skin_doc: SkinDocument):
	var layers = skin_doc.get_layers()
	var resolution = skin_doc.skin_resolution
	var final_img = Image.new()
	final_img.create(resolution, resolution, false, Image.FORMAT_RGBA8)
	final_img.fill(Color(1, 1, 1, 0))
	
	for layer in layers:
		var img = layer.image as Image
		var size = img.get_size()
		var new_img = Image.new()
		new_img.create(size.x, size.y, false, Image.FORMAT_RGBA8)
		new_img.copy_from(img)
		new_img.resize(resolution, resolution,
				Image.INTERPOLATE_NEAREST)
		
		final_img.blend_rect(new_img,
				Rect2(0, 0, resolution, resolution),
				Vector2(0, 0))
	
	return final_img
