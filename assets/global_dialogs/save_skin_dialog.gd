extends FileDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SaveSkinDialog_file_selected(path):
	# print(path)
	
	var layers = []
	
	for layer in DocumentManager.active_skin.layers:
		layers.append([layer.name ,Marshalls.raw_to_base64((layer.image as Image).save_png_to_buffer())])
	
	var data = {
		"skin_type": DocumentManager.active_skin.skin_type,
		"resolution": DocumentManager.active_skin.resolution,
		"regions": DocumentManager.active_skin.regions,
		"layers": layers
	}
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_var(data)
	file.close()
	#var exp_img = SkinRenderer.render_skin_export(DocumentManager.active_skin)
	#exp_img.save_png(path)
