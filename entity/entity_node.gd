class_name EntityNode extends PhysicsBody2D



var active:= false

var initialized:= false


@export var def: EntityDef

var data: EntityData

@export var inventory: Inventory


@export var state_machine: StateMachine

@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var component_root: Node

@export var hurtbox: Hurtbox




func _initialize(_entity_data: EntityData = null) -> void:

	_setup()






func _setup() -> void:

	assert(def != null, "No entity definition for %s" % self.name)

	if initialized:

		return

	initialized = true

	for component in get_all_components():

		component._setup(self)

	if state_machine:

		state_machine.setup(self)

	if def.default_inventory:

		inventory = def.default_inventory.duplicate_deep()





func _load_data(entity_data: EntityData) -> void:

	data = entity_data











func get_def() -> EntityDef:

	return def



func get_data() -> EntityData:

	return data



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

	return display_name




func get_component(component_script: Script) -> Component:

	for component in get_all_components():

		if component.get_component_script() == component_script:

			return component

	return null



func get_all_components() -> Array:

	return component_root.get_children()







func is_active() -> bool:

	return active



func is_unique() -> bool:

	return def.unique_id != &""

	








func _activate() -> void:

	active = true

	show()

	body_collision.disabled = false





func _deactivate() -> void:

	active = false

	hide()

	body_collision.disabled = true




