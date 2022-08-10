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
				print_debug('unimplemented undo operation')
			Operation.OP_LAYER_DEL:
				print_debug('unimplemented undo operation')
			Operation.OP_LAYER_MOV:
				print_debug('unimplemented undo operation')
			Operation.OP_LAYER_MOD:
				var layer: SkinLayer = doc.layers[last_op.layer_idx]
				layer.image.copy_from(last_op.img_old)
			_:
				print_debug('unknown operation type', last_op.op_type)
		
		self._last_operation -= 1
		DocumentManager.active_layer_index = last_op.layer_idx
		DocumentManager.refresh_skin_buffers()
		DocumentManager.queue_render_skin()


func redo(doc: SkinDocument):
	if self._last_operation == self._operations.size() - 1:
		return  # nothing to redo
	if self._last_operation >= self._operations.size():
		# wrong last operation range
		self._last_operation = self._operations.size() - 1
	else:
		var last_op: Operation = self._operations[self._last_operation + 1]
		
		match last_op.op_type:
			Operation.OP_LAYER_ADD:
				print_debug('unimplemented redo operation')
			Operation.OP_LAYER_DEL:
				print_debug('unimplemented redo operation')
			Operation.OP_LAYER_MOV:
				print_debug('unimplemented redo operation')
			Operation.OP_LAYER_MOD:
				var layer: SkinLayer = doc.layers[last_op.layer_idx]
				layer.image.copy_from(last_op.img_new)
			_:
				print_debug('unknown operation type', last_op.op_type)
		
		self._last_operation += 1
		DocumentManager.active_layer_index = last_op.layer_idx
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
	var img_old: Image = null
	var img_new: Image = null
