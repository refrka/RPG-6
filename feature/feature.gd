class_name Feature extends Node2D





var active:= false



func _initialize() -> void:

	_activate()






func _activate() -> void:

	active = true

	print("on")



func _deactivate() -> void:

	active = false

	print("off")