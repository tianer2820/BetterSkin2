extends Reference
class_name ToolBase


"""
the base class for all tools

variables that can be modified:
	name:
		the display name of the tool, format should be "tool_name"
	icon:
		a texture type to be displayed
	tool_type:
		a string used to identify the class, format should be "class_name"
	tool_labels:
		weither "builtin" or "user-defined"
	tool_props:
		a Dictionary of ToolProp class, used to identify what properties need to be displaied on the editor

must override functions:
	draw related:
		activate(active: bool)
		pen_down(uv: Vector2)
		pen_up(uv: Vector2)
		pen_move(uc: Vector2)

	save and load state:
		to_dict() -> Dictionary
		load_dict(dict)
	
	other:
		duplicate()

"""


# the displayed name and icon
var name: String
var icon: Texture


# tool type str used to identify tool class when saving and loading
var tool_type: String
# labels for tool grouping, ie builtin or user-defined
var tool_labels: Array

# define the displayed property list
# does not hold actual value
var tool_props: Dictionary

# dict that actually hold property values
var _properties: Dictionary = {}


func set_prop(prop_name, value) -> void:
	_properties[prop_name] = value
	ToolManager._tool_is_modified(self)

func get_prop(prop_name):
	if prop_name in _properties:
		return _properties[prop_name]
	var param = tool_props[prop_name] as ToolProp
	return param.value_default


# draw related, must override
func activate(active: bool):
	assert(false, "unimplemented")
func pen_down(uv: Vector2):
	assert(false, "unimplemented")
func pen_up(uv: Vector2):
	assert(false, "unimplemented")
func pen_move(uv: Vector2):
	assert(false, "unimplemented")


# save and load state
func to_dict() -> Dictionary:
	assert(false, "unimplemented")
	return {}
func load_dict(dict):
	assert(false, "unimplemented")





func duplicate():
	assert(false, "unimplemented")
func copy(other):
	name = other.name
	icon = other.icon
	tool_type = other.tool_type
	tool_labels = other.tool_labels.duplicate()
	tool_props = other.tool_props.duplicate()
	_properties = other._properties.duplicate()






# convenience functions for building property list

static func int_prop(default, val_min, val_max, val_step):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.INTEGER
	prop.value_default = default
	
	prop.value_min = val_min
	prop.value_max = val_max
	prop.value_step = val_step
	return prop

static func float_prop(default, val_min, val_max, val_step):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.FLOAT
	prop.value_default = default
	
	prop.value_min = val_min
	prop.value_max = val_max
	prop.value_step = val_step
	return prop

static func brush_tip_prop(default):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.BRUSH_TIP
	prop.value_default = default
	return prop

static func bool_prop(default):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.BOOL
	prop.value_default = default
	return prop

static func choice_prop(default_i, choices: Array):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.CHOICE
	prop.value_default = default_i
	
	prop.choices = choices
	return prop
