extends Node


signal skin_rerendered


var active_skin: SkinDocument setget _set_active_skin
var buffer_layer: SkinLayer setget _read_only
var rendered_skin: Image setget _read_only


var _queue_render_skin: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test code
	active_skin = SkinDocument.new(SkinDocument.TYPE_STEVE)

func _process(delta: float) -> void:
	# render skin each frame if needed
	if _queue_render_skin:
		rendered_skin = SkinRenderer.render_skin_doc(active_skin)
		emit_signal("skin_rerendered")
		_queue_render_skin = false


func ask_create_new_skin():
	pass
# load skin doc from file
func ask_load_skin():
	pass
# save skin doc to file
func ask_save_skin(save_as=false):
	pass


# open a loaded skin document
func _set_active_skin(doc):
	_read_only(doc)

func get_draw_layer() -> SkinLayer:
	return active_skin.get_active_layer()


# queue render skin on next frame. Must be called when skin is modified.
func queue_render_skin():
	_queue_render_skin = true
	


func _read_only(new_value):
	assert(false, "cannot assign to read-only property")
