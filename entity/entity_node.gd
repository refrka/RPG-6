class_name EntityNode extends PhysicsBody2D


var initialized:= false


@export var def: EntityDef

var data: EntityData

@export var state_machine: StateMachine

@export var component_root: ComponentRoot











func _initialize() -> void:

	initialized = true

	component_root.setup(self)

	if state_machine:

		state_machine.setup(self)











func get_component(component_name: StringName) -> Component:

	for component in component_root.get_children():

		if component.get_component_name() == component_name:

			return component

	return null




func get_all_components() -> Array:

	return component_root.get_children()





func get_entity_id() -> StringName:

	var entity_id = def.entity_id

	if def.template:

		entity_id = def.template.entity_id

	return entity_id






func load_data(entity_data: EntityData) -> void:

	data = entity_data

	data.node = self

	global_position = data.last_known_position





func update_location(location_id: StringName, spawn_id: StringName) -> void:

	if data:

		var location_scene = Scenes.get_location_scene(location_id)

		data.last_known_location_id = location_id

		var spawn_point = location_scene.get_spawn_point(spawn_id)

		data.last_known_position = spawn_point.global_position





func _get_dictionary() -> Dictionary:

	var save_dict = {}

	return save_dict





func _load_dictionary() -> void:

	pass



