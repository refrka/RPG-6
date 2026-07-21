class_name Component extends Node





var entity: EntityNode

var initialized:= false

var active:= false





func _initialize(_entity: EntityNode) -> void:

	if initialized:

		return

	entity = _entity

	initialized = true








func get_component_script() -> Script:

	return get_script()







func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false
