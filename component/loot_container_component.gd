class_name LootContainerComponent extends InteractableComponent




@export var loot_table: LootTable

@export var locked:= false

@export var key_item_def: ItemDef



var looted:= false




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED





func set_lock_state(state: bool) -> void:

	locked = state





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if !looted and loot_table:

		entity.destructible = false






func _interact() -> bool:

	looted = true

	if locked:

		locked = false

		UI.show_notice("Container unlocked with %s" % key_item_def.display_name)

	return super()







func _can_interact() -> bool:

	var can_interact:= false

	if loot_table:

		can_interact = true

	if !entity.inventory.is_empty():

		can_interact = true

	if looted:

		can_interact = false

	return can_interact






func _execute() -> void:

	entity.body_sprite.frame = 1

	var loot = loot_table.get_loot()

	var inventory_items = entity.inventory.item_list

	for item_data in inventory_items:

		if !loot.has(item_data.get_item_def):

			loot[item_data.get_item_def()] = 0
		
		loot[item_data.get_item_def()] += item_data.get_count()

		entity.inventory.remove_data(item_data)

	var player = Game.get_player()

	for item_def in loot:

		var count = loot[item_def]

		player.inventory.add_items(item_def, count)

	interaction_ended.emit()







func can_unlock(actor_entity: EntityNode) -> bool:

	if !key_item_def:

		return false

	return actor_entity.inventory.has_item_def(key_item_def)