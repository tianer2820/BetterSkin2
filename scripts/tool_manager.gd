extends Node

# tool manager only manage On Canvas Tools
# Filter Tools that are accessed from the edit menu will not
# be managed here. They will be created when used and deleted
# after use, and the state will not be saved


# added or removed tool from tool box
signal tool_list_changed
# selected different tool
signal active_tool_changed
# picked a new color
signal prime_color_changed
# tool property is changed
signal tool_modified(modified_tool)


const TOOL_SAVE_DIR = "user://saved_tools/"

# actual tool box that hold tool objects
var _tool_list: Array = []
var _active_tool_index = -1

var _prime_color: Color = Color(1, 1, 1)


func _ready() -> void:
		# test code (load tools)
	var test_tool = load(
			"res://scripts/tools/test_tool.gd") as GDScript
	for i in range(1):
		var inst = test_tool.new()
		_tool_list.append(inst)
	_check_active_tool_valid()
	emit_signal("tool_list_changed")


# manipulate tool list

func add_tool(tool_obj):
	assert(tool_obj is ToolBase, "tool_obj must be ToolBase")
	_tool_list.append(tool_obj)
	_check_active_tool_valid()
	emit_signal("tool_list_changed")

func remove_tool(tool_obj):
	_tool_list.erase(tool_obj)
	_check_active_tool_valid()
	emit_signal("tool_list_changed")

func get_tool_list() -> Array:
	return _tool_list.duplicate()


# active tool

func set_active_tool(tool_obj: ToolBase):
	var i = _tool_list.find(tool_obj)
	assert(i != -1, "tool_obj not found in tool list")
	_do_set_active_tool(i)
	
func get_active_tool() -> ToolBase:
	if _active_tool_index == -1 or _active_tool_index >= _tool_list.size():
		return null
	return _tool_list[_active_tool_index]

# make sure active tool points to a valid index in the tool list
func _check_active_tool_valid():
	if _tool_list.size() == 0:
		_do_set_active_tool(-1)
	else:
		_do_set_active_tool(
			int(clamp(_active_tool_index,
					0, _tool_list.size() - 1)))

func _do_set_active_tool(new_index):
	var old_tool = get_active_tool()
	if old_tool != null:
		old_tool.activate(false)
	_active_tool_index = new_index
	if(new_index != -1):
		get_active_tool().activate(true)
	emit_signal("active_tool_changed")

# just to emit tool_modified signal.
# Should only be called from ToolBase.
func _tool_is_modified(modified_tool):
	emit_signal("tool_modified", modified_tool)


# prime color

func set_prime_color(new_color: Color):
	_prime_color = new_color
	emit_signal("prime_color_changed")

func get_prime_color() -> Color:
	return _prime_color


# draw related
func pen_down(uv: Vector2):
	get_active_tool().pen_down(uv)
func pen_move(uv: Vector2):
	get_active_tool().pen_move(uv)
func pen_up(uv: Vector2):
	get_active_tool().pen_up(uv)







# save/load tools

# safe way to get tool save dir, as it makes sure it exist
func _get_tool_save_dir() -> Directory:
	var tool_dir = Directory.new()
	if tool_dir.open(TOOL_SAVE_DIR) == OK:
		return tool_dir
	elif tool_dir.make_dir_recursive(TOOL_SAVE_DIR) == OK:
		tool_dir.open(TOOL_SAVE_DIR)
		return tool_dir
	else:
		assert(false, "cannot open/create tool save folder at: " + ProjectSettings.globalize_path(TOOL_SAVE_DIR))
		return null

func save_tools():
	assert(false, "Unimplemented")
func load_tools():
	assert(false, "Unimplemented")
func load_default_tools():
	assert(false, "Unimplemented")
