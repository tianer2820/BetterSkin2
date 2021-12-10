extends HSplitContainer



var _percent_offset: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_splitter_dragged(offset: int) -> void:
	_percent_offset = self.split_offset / rect_size.x

func _on_splitter_resized() -> void:
	self.split_offset = rect_size.x * _percent_offset
	self.clamp_split_offset()

