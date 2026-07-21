class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var entity_data: EntityData




var initialized:= false










func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	return true





func _load(_entity_data: EntityData = null) -> bool:

	return true



















func get_entity_def() -> EntityDef:

	return entity_def


func get_entity_data() -> EntityData:

	return entity_data


func get_display_name() -> String:

	var display_name = "[MissingNo]"

	if entity_def:

		display_name = entity_def.display_name

	return display_name