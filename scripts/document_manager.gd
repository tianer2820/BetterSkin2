extends Node


var active_document: SkinDocument
var buffer_layer: SkinLayer
var rendered_skin: Image

signal document_render_changed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test code
	active_document = SkinDocument.new(SkinDocument.TYPE_STEVE)
	emit_signal("document_render_changed")


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


# should be called only by SkinDocument class
# will update the render and send signal
func _document_modified():
	# update render
	rendered_skin = SkinRenderer.render_skin_doc(active_document)
#	rendered_skin = active_document.get_layers()[0].image
	emit_signal("document_render_changed")

