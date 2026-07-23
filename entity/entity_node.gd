class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef

@export var entity_data: EntityData




@export_group("Node References")

@export var state_machine: StateMachine

@export var component_root: Node

@export var nav_agent: NavigationAgent2D




var active:= false

var initialized:= false



var inventory:= Inventory.new()






func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	for component in get_all_components():

		component._initialize(self)

	if entity_def.default_inventory:

		inventory = entity_def.default_inventory.duplicate()

		inventory._initialize()

	_deactivate()

	return true





func _load(_entity_data: EntityData = null) -> bool:

	return true







func reposition(new_position: Vector2) -> void:

	global_position = new_position









func get_entity_def() -> EntityDef:

	return entity_def



func get_entity_data() -> EntityData:

	return entity_data



func get_entity_id() -> StringName:

	var def = get_entity_def()

	return def.entity_id



func get_unique_id() -> StringName:

	var def = get_entity_def()

	return def.unique_id



func get_display_name() -> String:

	var display_name = "[MissingNo]"

	if entity_def:

		display_name = entity_def.display_name

	return display_name



func get_all_components() -> Array:

	return component_root.get_children()



func get_component(component_script: Script) -> Component:

	for component in get_all_components():

		if component.get_component_script() == component_script:

			return component

	return null









func _activate() -> void:

	active = true

	for component in get_all_components():

		component._activate()





func _deactivate() -> void:

	active = false

	for component in get_all_components():

		component._deactivate()