class_name EntityNode extends PhysicsBody2D


var initialized:= false


@export var def: EntityDef

var data: EntityData

var inventory:= Inventory.new()

@export var state_machine: StateMachine

@export var component_root: ComponentRoot




@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D







func _initialize() -> void:

	assert(def != null, "No entity definition for %s" % self.name)

	initialized = true

	component_root.setup(self)

	if state_machine:

		state_machine.setup(self)

	if not self is PlayerNode and def.default_inventory:

		inventory = def.default_inventory.duplicate()






func one_time_setup() -> void:

	if def.default_inventory:

		inventory = def.default_inventory.duplicate()





func get_component(component_name: StringName) -> Component:

	for component in component_root.get_children():

		if component.get_component_name() == component_name:

			return component

	return null




func get_all_components() -> Array:

	return component_root.get_children()





func get_entity_id() -> StringName:

	var entity_id = def.entity_id

	return entity_id



func get_unique_id() -> StringName:

	return def.unique_id



func get_template_id() -> StringName:

	var template_id = &""

	if def.template:

		template_id = def.template.entity_id

	return template_id




func get_display_name() -> String:

	var display_name = def.display_name

	if def.template:

		display_name = def.template.display_name

	return display_name














func load_data(entity_data: EntityData) -> void:

	if entity_data == null:

		return

	data = entity_data

	data.node = self

	data.def = def

	global_position = data.last_known_position





func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

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









func _activate() -> void:

	show()

	for component in get_all_components():

		component._activate()

	body_collision.disabled = false





func _deactivate() -> void:

	hide()

	for component in get_all_components():

		component._deactivate()

	body_collision.disabled = true