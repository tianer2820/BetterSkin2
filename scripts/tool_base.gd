extends Reference
class_name ToolBase


"""
the base class for all tools

variables that can be modified:
	name:
		the display name of the tool, format should be "tool_name"
	icon:
		a texture type to be displayed

must override functions:
	activate(active: bool)
	pen_down(uv: Vector2)
	pen_up(uv: Vector2)
	pen_move(uc: Vector2)

"""


# the displayed name and icon
var name: String
var icon: Texture


# define the displayed property list
# does not hold actual value
var _displayed_props: Dictionary
# dict that actually hold property values
var _props: Dictionary = {}

# add a property to the tool display panel
func add_prop(name: String, prop: ToolProp) -> void:
	_displayed_props[name] = prop
	self.set_prop(name, prop.value_default)

# set the value of a tool property
func set_prop(prop_name, value) -> void:
	_props[prop_name] = value
	ToolManager.announce_tool_modified(self)

func get_prop(prop_name):
	if prop_name in _props:
		return _props[prop_name]
	var property = _displayed_props[prop_name] as ToolProp
	return property.value_default


# draw related, must override
func activate(active: bool):
	assert(false, "unimplemented")
func pen_down(uv: Vector2):
	assert(false, "unimplemented")
func pen_up(uv: Vector2):
	assert(false, "unimplemented")
func pen_move(uv: Vector2):
	assert(false, "unimplemented")

#
#func duplicate():
#	assert(false, "unimplemented")
#func copy(other):
#	name = other.name
#	icon = other.icon
#	tool_type = other.tool_type
#	tool_is_builtin = other.tool_is_builtin
#	displayed_props = other.displayed_props.duplicate()
#	_properties = other._properties.duplicate()
#
#
## save & loading
#func to_dict() -> Dictionary:
#	var save_properties = _properties.duplicate()
#	for key in save_properties.keys():
#		var value = save_properties[key]
#		if value is BrushTip:
#			save_properties[key] = value.to_dict()
#	var save_dict = {
#		'name': name,
#		'tool_type': tool_type,
#		'properties': save_properties,
#	}
#	return save_dict
#func load_dict(dict: Dictionary):
#	name = dict['name']
#	tool_type = dict['tool_type']
#	_properties = dict['properties']
#	for key in _properties.keys():
#		var value = _properties[key]
#		if value is Dictionary: # special object
#			if value['type'] == 'brush_tip':
#				var brush_tip = BrushTip.new()
#				brush_tip.load_dict(value)
#				_properties[key] = brush_tip


# convenience functions for building property list

static func int_prop(default, val_min, val_max, val_step):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.INTEGER
	prop.value_default = default
	
	prop.value_min = val_min
	prop.value_max = val_max
	prop.value_step = val_step
	return prop

static func float_prop(default, val_min, val_max):
	var prop = ToolProp.new()
	prop.prop_type = ToolProp.FLOAT
	prop.value_default = default
	
	prop.value_min = val_min
	prop.value_max = val_max
	return prop

static func brush_tip_prop(default: BrushTip):
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
