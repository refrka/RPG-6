class_name GameScene extends CanvasItem



var active:= false





func _enter_tree() -> void:

	Scenes.register_scene(self)

	_deactivate()



func _exit_tree() -> void:

	Scenes.unregister_scene(self)








func is_active() -> bool:

	return active














func _activate() -> void:

	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()