extends FileDialog



func _on_OpenPNGDialog_files_selected(paths: PoolStringArray) -> void:
	for path in paths:
		path = path as String
		var file_name = path.get_file().get_basename()
		var new_layer = SkinLayer.new(file_name, Vector2(1, 1))
		new_layer.image.load(path)
		DocumentManager.add_layer(new_layer, DocumentManager.layers.size() )
	DocumentManager.queue_render_skin()
