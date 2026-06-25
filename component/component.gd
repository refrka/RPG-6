class_name Component extends Node





var entity: EntityNode

var active:= true



func _setup(_entity: EntityNode) -> void:

	entity = _entity








func get_component_name() -> StringName:

	return name.trim_suffix("Component").to_snake_case()







func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false





