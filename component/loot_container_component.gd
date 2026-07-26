class_name LootContainerComponent extends InteractableComponent




@export var loot_table: LootTable



var looted:= false








func _interact() -> bool:

	looted = true

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

	return super()







func _can_interact() -> bool:

	var has_loot:= false

	if loot_table:

		has_loot = true

	if !entity.inventory.is_empty():

		has_loot = true

	if looted:

		has_loot = false

	return has_loot