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



func get_component_id() -> StringName:

	return name




func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false





func _get_dictionary() -> Dictionary:

	return {}



func _load_dictionary(_save_dict: Dictionary) -> void:

	return