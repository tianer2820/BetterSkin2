extends PanelContainer



var _active_tool: ToolBase



# panel resources
var INTEGER_PANEL = preload("res://assets/tool_settings_panel/property_panels/integer_panel.tscn") as PackedScene



func _ready() -> void:
	ToolManager.connect("active_tool_changed",
			self, "_on_active_tool_changed")
	ToolManager.connect("tool_modified",
			self, "_on_manager_tool_modified")
	_load_tool(ToolManager.get_active_tool())

# load the tool to be displayed
func _load_tool(tool_obj):
	_clear()
	tool_obj = tool_obj as ToolBase
	if tool_obj == null:
		return
	# add coorosponding panels and connect signals
	_active_tool = tool_obj
	var prop_names = _active_tool.displayed_props.keys()
	for p_name in prop_names:
		var prop = _active_tool.displayed_props[p_name]
		prop = prop as ToolProp
		match prop.prop_type:
			ToolProp.INTEGER:
				var panel = INTEGER_PANEL.instance() as PropPanelBase
				panel.set_name(p_name)
				panel.set_prop(prop)
				panel.set_value(tool_obj.get_prop(p_name))
				panel.connect("value_changed", self, "_on_prop_panel_change", [p_name, panel])
				$VBox/Scroll/VBox.add_child(panel)
			_:
				pass

func _clear():
	for child in $VBox/Scroll/VBox.get_children():
		child.queue_free()


# manager signals

func _on_active_tool_changed():
	var active_tool = ToolManager.get_active_tool()
	_load_tool(active_tool)

func _on_manager_tool_modified():
	var active_tool = ToolManager.get_active_tool()
	_load_tool(active_tool)


# child panel signal
func _on_prop_panel_change(p_name, panel: PropPanelBase):
	_active_tool.set_prop(p_name, panel.get_value())
