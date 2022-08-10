"""
document history manager that manages the undo/redo
history for a single opened document.

Should create different history manager for different
documents, so opening multiple skins in tabs is possible
in the future.

History manager does not keep track which document it
is for, so the targeted document must be passed in
each time a function is called. This is to avoid
potential problems with pointers and memory management

Three types of operations are supported:
	layer add, layer delete, layer move, and layer modify
"""

class_name HistoryManager


var max_history_count = 64
var _operations = []
var _last_operation = -1

func add_operation(op: Operation):
	if self._last_operation < 0:
		self._operations.append(op)
		self._last_operation = 0
	else:
		# remove old history
		self._operations.resize(self._last_operation + 1)
		# add new history
		self._operations.append(op)
		self._last_operation += 1
	
	while self._operations.size() > max_history_count:
		self._operations.pop_front()
	
func undo(doc: SkinDocument):
	if self._last_operation < 0:
		self._last_operation = -1
		return  # nothing to undo
	if self._last_operation >= self._operations.size():
		# wrong last operation range
		self._last_operation = self._operations.size() - 1
	else:
		var last_op: Operation = self._operations[self._last_operation]
		
		match last_op.op_type:
			Operation.OP_LAYER_ADD:
				doc.layers.pop_at(last_op.layer_idx)
				var index = clamp(DocumentManager.active_layer_index, 0, DocumentManager.active_skin.layers.size() - 1)
				DocumentManager.active_layer_index = index
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_DEL:
				var new_layer = SkinLayer.new(last_op.layer_name, last_op.img_old.get_size())
				new_layer.image.copy_from(last_op.img_old)
				doc.layers.insert(last_op.layer_idx, new_layer)
				DocumentManager.active_layer_index = last_op.layer_idx
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_MOV:
				var layer = doc.layers.pop_at(last_op.layer_idx2)
				doc.layers.insert(last_op.layer_idx, layer)
				DocumentManager.active_layer_index = last_op.layer_idx
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_MOD:
				var layer: SkinLayer = doc.layers[last_op.layer_idx]
				layer.image.copy_from(last_op.img_old)
				DocumentManager.active_layer_index = last_op.layer_idx
			
			_:
				print_debug('unknown operation type', last_op.op_type)
		
		self._last_operation -= 1
		DocumentManager.refresh_skin_buffers()
		DocumentManager.queue_render_skin()


func redo(doc: SkinDocument):
	if self._last_operation == self._operations.size() - 1:
		return  # nothing to redo
	if self._last_operation >= self._operations.size():
		# wrong last operation range
		self._last_operation = self._operations.size() - 1
	else:
		var next_op: Operation = self._operations[self._last_operation + 1]
		
		match next_op.op_type:
			Operation.OP_LAYER_ADD:
				var new_layer = SkinLayer.new(next_op.layer_name, next_op.img_new.get_size())
				new_layer.image.copy_from(next_op.img_new)
				doc.layers.insert(next_op.layer_idx, new_layer)
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_DEL:
				doc.layers.pop_at(next_op.layer_idx)
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_MOV:
				var layer = doc.layers.pop_at(next_op.layer_idx)
				doc.layers.insert(next_op.layer_idx2, layer)
				DocumentManager.queue_emit_layers_changed()
				
			Operation.OP_LAYER_MOD:
				var layer: SkinLayer = doc.layers[next_op.layer_idx]
				layer.image.copy_from(next_op.img_new)
				
			_:
				print_debug('unknown operation type', next_op.op_type)
		
		self._last_operation += 1
		var index = clamp(next_op.layer_idx, 0, DocumentManager.active_skin.layers.size() - 1)
		DocumentManager.active_layer_index = index
		DocumentManager.refresh_skin_buffers()
		DocumentManager.queue_render_skin()


class Operation:
	enum{
		OP_LAYER_ADD,
		OP_LAYER_DEL,
		OP_LAYER_MOV,
		OP_LAYER_MOD,
	}
	
	var op_type = -1
	var layer_idx: int = 0
	var layer_idx2: int = -1
	var img_old: Image = null  # image before the operation
	var img_new: Image = null  # image after the operation
	var layer_name: String = 'layer'
