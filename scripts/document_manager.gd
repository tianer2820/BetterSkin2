extends Node


"""
Document manager holds the current opened skin document and manage the rendering, modification and undo/redo operations.

There are three different type of draw targets available:
	layers in the skin document
	the tool_indecator layer
	the draw_buffer layer

layers in the skin document should not be modified by tools directly, as undo/redo cannot be correctly managed in this way. 

Tools should draw on the draw_buffer layer instead, and let document manager to merge down that layer instead.

The tool_indecator layer are used to preview the effective range of the tool, i.e. brush size, shape indecator. It should be cleared and redrew when the mouse pointer moves.

"""

# the skin render changed and all display should refresh
signal skin_rerendered
# layer change notifications
signal active_layer_changed
signal layers_changed

var GLOBAL_DIALOGS = "/root/GUIRoot/GlobalDialogs/"

# currently opened document
var active_skin: SkinDocument setget _set_active_skin
var active_layer: SkinLayer setget _set_active_layer, _get_active_layer
var active_layer_index: int = -1 setget _set_active_layer_index
var layers: Array setget _read_only, _get_layers
# tooling layers
var draw_buffer_layer: SkinLayer setget _read_only
var tool_indecator_layer: SkinLayer setget _read_only
# the image that should be displaied on canvas
var rendered_skin: Image setget _read_only
# mask for selection
var selection_mask: Image setget _read_only


# do skin need to be rendered on next frame
var _queue_render_skin: bool = true
# send signal flags
var _emit_layers_changed: bool = false
var _emit_active_layer_changed: bool = false

func _ready() -> void:
	# test code
	active_skin = SkinDocument.new(SkinDocument.TYPE_STEVE)
	active_layer_index = 0
	tool_indecator_layer = SkinLayer.new("tool_indecator",
			Vector2(active_skin.resolution, active_skin.resolution))
	draw_buffer_layer = SkinLayer.new("draw_buffer",
			Vector2(active_skin.resolution, active_skin.resolution))
	selection_mask = Image.new()
	selection_mask.create(active_skin.resolution, active_skin.resolution, false, Image.FORMAT_RGBA8)


func _process(delta: float) -> void:
	# render skin if needed
	if _queue_render_skin:
		rendered_skin = SkinRenderer.render_skin_preview()
		emit_signal("skin_rerendered")
		_queue_render_skin = false
	
	# emit queued signals
	if _emit_active_layer_changed:
		emit_signal("active_layer_changed")
		_emit_active_layer_changed = false
	if _emit_layers_changed:
		emit_signal("layers_changed")
		_emit_layers_changed = false


# popup window to create a new skin
func ask_create_new_skin():
	pass
# popup window to browse and open a skin file
func ask_open_skin():
	pass
# popup window to save skin to a file
func ask_save_skin(save_as=false):
	pass
func ask_import():
	var dialog: FileDialog = get_node(CST.IMPORT_PNG_DIALOG)
	dialog.popup_centered()
func ask_export():
	var dialog: FileDialog = get_node(CST.EXPORT_PNG_DIALOG)
	dialog.popup_centered()
	


# load a new skin (currently invalid)
func _set_active_skin(doc):
	_read_only(doc)

func _set_active_layer(new_value: SkinLayer):
	var index = active_skin.layers.find(new_value)
	assert(index != -1, "layer not in active skin")
	self.active_layer_index = index

func _get_active_layer() -> SkinLayer:
	if(active_skin == null):
		return null
	if(active_layer_index < 0):
		return null
	return active_skin.layers[active_layer_index]

func _set_active_layer_index(new_value):
	assert(new_value >= 0 and new_value < active_skin.layers.size(),
			"invalid index value")
	if active_layer_index == new_value:
		return
	active_layer_index = new_value
	var new_res = self.active_layer.image.get_size()
	draw_buffer_layer = SkinLayer.new("draw_buffer", new_res)
	queue_emit_active_layer_changed()

func _get_layers() -> Array:
	return active_skin.layers.duplicate(false)


func add_layer(new_layer: SkinLayer, at_index: int = 0):
	assert(new_layer != null, "new layer cannot be null")
	assert(not new_layer in active_skin.layers,
			"new layer already in layer list")
	at_index = clamp(at_index, 0, active_skin.layers.size())
	active_skin.layers.insert(at_index, new_layer)
	if at_index <= active_layer_index:
		active_layer_index += 1
	queue_emit_layers_changed()
	queue_render_skin()

func pop_layer(at_index: int = 0) -> SkinLayer:
	assert(at_index >= 0 and at_index < active_skin.layers.size(),
			"index out of range")
	var ret = active_skin.layers.pop_at(at_index)
	if at_index <= active_layer_index:
		active_layer_index -= 1
	queue_emit_layers_changed()
	queue_render_skin()
	return ret

func rename_layer(index: int, new_name: String):
	active_skin.layers[index].name = new_name
	queue_emit_layers_changed()


# apply the current draw buffer layer, create undo/redo actions
func apply_draw_buffer():
	SkinRenderer.merge_layers(self.draw_buffer_layer, self.active_layer)
	print_debug("add undo/redo action here")

# queue render skin on next frame. Must be called when skin is modified.
func queue_render_skin():
	_queue_render_skin = true
func queue_emit_active_layer_changed():
	_emit_active_layer_changed = true
func queue_emit_layers_changed():
	_emit_layers_changed = true


func _read_only(new_value):
	assert(false, "cannot assign to read-only property")
