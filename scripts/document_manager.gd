extends Node


signal document_rerendered


var active_document: SkinDocument
var buffer_layer: SkinLayer
var rendered_skin: Image


var _queue_render_skin: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test code
	active_document = SkinDocument.new(SkinDocument.TYPE_STEVE)

func _process(delta: float) -> void:
	if _queue_render_skin:
		rendered_skin = SkinRenderer.render_skin_doc(active_document)
		emit_signal("document_rerendered")
		_queue_render_skin = false


func create_new_skin():
	pass
# load skin doc from file
func load_skin():
	pass
# save skin doc to file
func save_skin():
	pass


# open a loaded skin document
func open_skin_document(doc):
	pass
# get the currently opened skin doc
func get_current_skin() -> SkinDocument:
	pass
	return active_document

func get_draw_layer() -> SkinLayer:
	return active_document.get_active_layer()


# queue render skin on next frame. Must be called when skin is modified.
func queue_render_skin():
	_queue_render_skin = true
	
