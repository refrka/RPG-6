class_name Overlay extends Control


@warning_ignore("unused_signal")

signal close_requested


@export var pause:= false

var active:= false










func _enter_tree() -> void:

	UI.register_overlay(self)

	_deactivate()




func _exit_tree() -> void:

	UI.unregister_overlay(self)




func _close() -> void:

	pass




func toggle() -> void:

	if active:

		_deactivate()

	else:

		_activate()






func _activate() -> void:

	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()