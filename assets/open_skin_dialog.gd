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


func _on_OpenSkinDialog_file_selected(path):
	print(path)
	var file = File.new()
	file.open(path, File.READ)
	var data = file.get_var()
	file.close()
	
	DocumentManager.active_skin.skin_type = data["skin_type"]
	DocumentManager.active_skin.resolution = data["resolution"]
	DocumentManager.active_skin.regions = data["regions"]
	for layer in data["layers"]:
		var new_layer = SkinLayer.new("Layer", Vector2(1,1))
		new_layer.image.load_png_from_buffer(Marshalls.base64_to_raw(layer))
		DocumentManager.add_layer(new_layer, DocumentManager.layers.size())
	
	DocumentManager.queue_render_skin()
