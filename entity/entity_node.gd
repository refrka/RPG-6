class_name EntityNode extends PhysicsBody2D




@export var entity_def: EntityDef




@export_group("Node References")

@export var body_sprite: Sprite2D

@export var state_machine: StateMachine

@export var component_root: Node

@export var nav_agent: NavigationAgent2D




var active:= false

var initialized:= false

var authored:= false



var inventory:= Inventory.new()








func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	for component in get_all_components():

		component._initialize(self)

	if state_machine:

		state_machine.setup(self)

	if entity_def.default_inventory:

		inventory = entity_def.default_inventory.duplicate()

		inventory._initialize()

	_deactivate()

	return true





func use_item(item_data: ItemData) -> void:

	var item_def = item_data.get_item_def()

	if item_def is ConsumableDef:

		var effects_component = get_component(EffectsComponent)

		for effect in item_def.effects_on_consume:

			effects_component.add_effect(effect)
	
	item_data.remove_amount(1)





func reposition(new_position: Vector2) -> void:

	global_position = new_position




func reset() -> void:

	pass






func get_entity_def() -> EntityDef:

	return entity_def




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

		var script = component.get_component_script()

		while script != null:

			if script == component_script:

				return component

			script = script.get_base_script()

	return null



func get_component_by_id(component_id: StringName) -> Component:

	for component in get_all_components():

		if component.get_component_id() == component_id:

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






func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["unique_id"] = get_unique_id()

	save_dict["location_id"] = Scenes.get_location_scene().get_location_id()

	save_dict["inventory"] = inventory.get_dictionary()

	save_dict["components"] = { }

	for component in get_all_components():

		var dict = component._get_dictionary()

		if !dict.is_empty():

			save_dict["components"][component.get_component_id()] = dict

	return save_dict





func _load_dictionary(save_dict: Dictionary) -> void:

	if save_dict.has("inventory"):

		inventory.load_dictionary(save_dict["inventory"])

	for component_id in save_dict["components"]:

		var dict = save_dict["components"][component_id]

		var component = get_component_by_id(component_id)

		component._load_dictionary(dict)

