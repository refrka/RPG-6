class_name Feature extends Node2D



var active:= false

var location_scene: LocationScene





func _ready() -> void:

	add_to_group("feature")




func _initialize(_location_scene: LocationScene) -> void:

	location_scene = _location_scene

	_deactivate()




func _activate() -> void:

	active = true



func _deactivate() -> void:

	active = false