class_name EntityNode extends PhysicsBody2D


@warning_ignore("unused_signal")

signal removal_requested

signal died


@export var unique_id: StringName

@export var entity_def: EntityDef

@export var destructible:= true

@export var death_loot_table: LootTable


@export_group("Node References")

@export var visual_root: Node2D

@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var body_hurtbox: Hurtbox

@export var combat_hitbox: Hitbox

@export var state_machine: StateMachine

@export var component_root: Node

@export var nav_agent: NavigationAgent2D




var active:= false

var initialized:= false

var authored:= false




var added_visual_nodes: Array[Node2D]



var inventory:= Inventory.new()








func _initialize() -> bool:

	assert(entity_def != null)

	if initialized:

		return false

	initialized = true

	if entity_def.default_inventory:

		inventory = entity_def.default_inventory.duplicate(true)

		inventory._initialize()

	for component in get_all_components():

		component._initialize(self)

	if state_machine:

		state_machine.setup(self)

	if body_hurtbox:

		body_hurtbox.setup(self)

	_deactivate()

	var health_component = get_component(HealthComponent)

	if health_component:

		health_component.health_depleted.connect(_on_health_depleted)

	return true







func accept_hit(damage_package: DamagePackage) -> bool:

	var health_component = get_component(HealthComponent)

	if health_component and health_component.receive_damage_package(damage_package):

		return true

	return false






func add_visual_node(visual_node: Node2D) -> void:

	if visual_node.get_parent() != null:

		visual_node.reparent(visual_root)

	else:

		visual_root.add_child(visual_node)

	added_visual_nodes.append(visual_node)

	if visual_node is EntityNode:

		visual_node.removal_requested.connect(_on_added_visual_node_removal_requested.bind(visual_node))







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

	if def.unique_id != &"":

		return def.unique_id

	else:

		return unique_id



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

	








func is_unique() -> bool:

	return entity_def.unique_id != &""









func _on_health_depleted(final_damage_package: DamagePackage) -> void:

	if final_damage_package.source is PlayerNode:

		Events.fire(PlayerSlayedEntityEvent, {"entity_node": self, "final_damage_package": final_damage_package})

	if death_loot_table:

		var loot = death_loot_table.get_loot()

		Game.drop_items(loot, global_position)

	died.emit()

	queue_free.call_deferred()






func _on_added_visual_node_removal_requested(visual_node: EntityNode) -> void:

	added_visual_nodes.erase(visual_node)

	visual_node.queue_free.call_deferred()






func _update_node() -> void:

	body_sprite.texture = entity_def.body_texture







func _activate() -> void:

	active = true

	for component in get_all_components():

		component._activate()

	body_collision.disabled = false





func _deactivate() -> void:

	active = false

	for component in get_all_components():

		component._deactivate()

	body_collision.disabled = true






func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["unique_id"] = get_unique_id()

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






