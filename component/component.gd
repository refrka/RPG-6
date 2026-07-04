class_name Component extends Node





var entity: EntityNode

var active:= false



func _setup(_entity: EntityNode) -> void:

	entity = _entity

	_activate()








func get_component_name() -> StringName:

	return name.trim_suffix("Component").to_snake_case()







func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false







