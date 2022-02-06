extends AspectRatioContainer


signal visibility_toggle(part_id, visibility)




func _on_Head_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.HEAD, not button_pressed)

func _on_Body_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.BODY, not button_pressed)

func _on_ArmL_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.ARM_L, not button_pressed)

func _on_ArmR_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.ARM_R, not button_pressed)

func _on_LegL_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.LEG_L, not button_pressed)

func _on_LegR_toggled(button_pressed: bool) -> void:
	emit_signal("visibility_toggle", CST.BodyPartID.LEG_R, not button_pressed)
