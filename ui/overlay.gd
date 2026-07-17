class_name Overlay extends Control



@export var pause:= false

var active:= false












func _enter_tree() -> void:

	UI.register_overlay(self)

	_deactivate()




func _exit_tree() -> void:

	UI.unregister_overlay(self)








func _activate() -> void:

	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()