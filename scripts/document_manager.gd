extends Node


"""
Document manager holds the current opened skin document and manage the rendering, modification and undo/redo operations.

There are three different type of draw targets available:
	layers in the skin document
	the tool_indicate_layer
	the draw_buffer layer

layers in the skin document should not be modified by tools directly, as undo/redo cannot be correctly managed in this way. 

Tools should draw on the draw_buffer layer instead, and let document manager to merge down that layer instead.

The tool_indicator layer are used to preview the effective range of the tool, i.e. brush size, shape indecator. It should be cleared and redrew when the mouse pointer moves.

"""

# the skin render changed and all display should refresh
signal skin_rerendered
# layer change notifications
signal active_layer_changed
signal layers_changed
signal skin_changed

var GLOBAL_DIALOGS = "/root/GUIRoot/GlobalDialogs/"

# currently opened document
var active_skin: SkinDocument setget _set_active_skin
var active_layer: SkinLayer setget _set_active_layer, _get_active_layer
var active_layer_index: int = -1 setget _set_active_layer_index
var layers: Array setget _read_only, _get_layers
# tooling layers
var draw_buffer_layer: SkinLayer setget _read_only
var tool_indicate_layer: SkinLayer setget _read_only

# undo redo history manager
var history_manager: HistoryManager setget _read_only

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
#	self.active_skin = SkinDocument.new(SkinDocument.TYPE_STEVE)
	self.active_skin = SkinDocument.create_steve()
	


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
	var dialog: FileDialog = get_node(CST.OPEN_SKIN_DIALOG)
	dialog.popup_centered()
	pass
# popup window to save skin to a file
func ask_save_skin(save_as=false):
	if save_as:
		var dialog: FileDialog = get_node(CST.SAVE_SKIN_DIALOG)
		dialog.popup_centered()
	pass
func ask_import():
	var dialog: FileDialog = get_node(CST.IMPORT_PNG_DIALOG)
	dialog.popup_centered()
func ask_export():
	var dialog: FileDialog = get_node(CST.EXPORT_PNG_DIALOG)
	dialog.popup_centered()
	


# load a new skin (currently invalid)
func _set_active_skin(skin: SkinDocument):
	active_skin = skin
	if skin != null:
		var res = self.active_skin.resolution
		tool_indicate_layer = SkinLayer.new("tool_indicator",
				Vector2(res, res))
		draw_buffer_layer = SkinLayer.new("draw_buffer",
				Vector2(res, res))
		selection_mask = Image.new()
		selection_mask.create(res, res, false, Image.FORMAT_RGBA8)
				
		self.active_layer_index = min(0, skin.layers.size() - 1)
		history_manager = HistoryManager.new()
		
	else:
		self.active_layer_index = -1
		self.tool_indicate_layer = null
		self.draw_buffer_layer = null
		self.selection_mask = null


func _set_active_layer(new_value: SkinLayer):
	var index = active_skin.layers.find(new_value)
	assert(index != -1, "layer not in active skin")
	self.active_layer_index = index

func _get_active_layer() -> SkinLayer:
	if(self.active_skin == null):
		return null
	if(self.active_layer_index < 0):
		return null
	return self.active_skin.layers[self.active_layer_index]

func _set_active_layer_index(new_value):
	assert(new_value < self.active_skin.layers.size(),
			"invalid index value")
	if active_layer_index == new_value:
		return
	active_layer_index = new_value
	
	self.refresh_skin_buffers()
	queue_emit_active_layer_changed()

func _get_layers() -> Array:
	return self.active_skin.layers.duplicate(false)


func add_layer(new_layer: SkinLayer, at_index: int = 0):
	assert(new_layer != null, "new layer cannot be null")
	assert(not new_layer in self.active_skin.layers,
			"new layer already in layer list")
	at_index = clamp(at_index, 0, self.active_skin.layers.size())
	self.active_skin.layers.insert(at_index, new_layer)
	if at_index <= active_layer_index:
		self.active_layer_index += 1
	queue_emit_layers_changed()
	queue_render_skin()

func pop_layer(at_index: int = 0) -> SkinLayer:
	assert(at_index >= 0 and at_index < self.active_skin.layers.size(),
			"index out of range")
	var ret = self.active_skin.layers.pop_at(at_index)
	if at_index <= self.active_layer_index and self.active_layer_index > 0:
		self.active_layer_index -= 1
	queue_emit_layers_changed()
	queue_render_skin()
	return ret

func rename_layer(index: int, new_name: String):
	self.active_skin.layers[index].name = new_name
	queue_emit_layers_changed()


# apply the current draw buffer layer, create undo/redo actions
func apply_draw_buffer():
	# save old layer
	var operation = HistoryManager.Operation.new()
	operation.op_type = HistoryManager.Operation.OP_LAYER_MOD
	operation.layer_idx = self.active_layer_index
	var layer_img = self.active_layer.image
	operation.img_old = Image.new()
	operation.img_old.copy_from(layer_img)
	# apply change
	layer_img.copy_from(self.draw_buffer_layer.image)
	# save new layer
	operation.img_new = Image.new()
	operation.img_new.copy_from(layer_img)
	
	self.history_manager.add_operation(operation)

	

# queue render skin on next frame. Must be called when skin is modified.
func queue_render_skin():
	_queue_render_skin = true
func queue_emit_active_layer_changed():
	_emit_active_layer_changed = true
func queue_emit_layers_changed():
	_emit_layers_changed = true

# refresh all skin layer buffers, used when applying undo/redo actions
func refresh_skin_buffers():
	draw_buffer_layer.copy_from(self.active_layer)
	
	
# undo redo
func undo():
	self.history_manager.undo(self.active_skin)
func redo():
	self.history_manager.redo(self.active_skin)


func _read_only(new_value):
	assert(false, "cannot assign to read-only property")
