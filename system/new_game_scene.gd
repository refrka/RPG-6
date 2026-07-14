class_name NewGameScene extends CanvasItem




var active:= false
























func _activate() -> void:
	
	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()




func _enter_tree() -> void:

	NewScenes.register_scene(self)




func _exit_tree() -> void:
	 
	NewScenes.unregister_scene(self)