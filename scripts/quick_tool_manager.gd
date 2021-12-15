extends Node


"""
The autoload node for doing quick tool switch.

use register_quick_tool() and clear_all_quick_tools() to manipulate the action-tool mapping.
"""


var _wait_for_event = null
var _quick_tool_enabled: ToolBase = null
var _tool_to_restore: ToolBase = null


var _action_tool_mapping: Dictionary = {}


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if _wait_for_event == null or _quick_tool_enabled == null:
		# no quick tool active now
		for action in _action_tool_mapping.keys():
			if Input.is_action_just_pressed(action):
				# enable quick tool
				_wait_for_event = action
				var tool_ = _action_tool_mapping[action]
				_quick_tool_enabled = tool_
				_tool_to_restore = ToolManager.get_active_tool()
				ToolManager.set_active_tool(tool_)
	elif _wait_for_event != null:
		# quick tool activated, wait for deactivation
		if not Input.is_action_pressed(_wait_for_event):
			ToolManager.set_active_tool(_tool_to_restore)
			_quick_tool_enabled = null
			_wait_for_event = null
			_tool_to_restore = null


func register_quick_tool(action: String, tool_: ToolBase):
	assert(action != null)
	assert(tool_ != null)
	_action_tool_mapping[action] = tool_

func clear_all_quick_tools():
	_action_tool_mapping = {}

