class_name EntityNode extends PhysicsBody2D


var initialized:= false


@export var def: EntityDef

var data: NewEntityData

var new_data: NewEntityData

var inventory:= Inventory.new()

@export var state_machine: StateMachine

@export var component_root: ComponentRoot




@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D







func _setup() -> void:

	assert(def != null, "No entity definition for %s" % self.name)

	if initialized:

		return

	initialized = true

	component_root.setup(self)

	if state_machine:

		state_machine.setup(self)





func _initialize(_entity_data: NewEntityData) -> void:

	pass






func one_time_setup() -> void:

	if def.default_inventory:

		inventory = def.default_inventory.duplicate()

		inventory.initialize()





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














func load_data(entity_data: NewEntityData) -> void:

	assert(entity_data != null, "Null entity_Data for %s" % self)

	data = entity_data

	data.node = self

	data.def = def

	if data.last_dict.has("components"):

		for component_name in data.last_dict["components"]:

			var dict = data.last_dict["components"][component_name]

			var component = get_component(component_name)

			if component:

				component.load_dictionary(dict)

	if data.last_dict.has("inventory"):

		inventory = Inventory.load_dictionary(data.last_dict["inventory"])






func load_new_data(entity_data: NewEntityData) -> void:

	assert(entity_data != null, "Null entity_data for %s" % self)

	new_data = entity_data

	new_data.node = self

	new_data.def = def

	




func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

	if data:

		var location_scene = NewScenes.get_location_scene(location_id)

		data.last_known_location_id = location_id

		var spawn_point = location_scene.get_spawn_point(spawn_id)

		data.last_known_position = spawn_point.global_position









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






func _enable() -> void:

	for component in get_all_components():

		if component.has_method("enable"):

			component.enable()




func _disable() -> void:

	for component in get_all_components():

		if component.has_method("disable"):

			component.disable()