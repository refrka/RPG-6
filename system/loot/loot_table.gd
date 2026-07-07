class_name LootTable extends Resource


@export var entries: Array[LootEntry]








func get_loot(roll: float) -> Array[NewItemData]:

	var loot: Array[NewItemData] = []

	for entry in entries:

		if roll <= entry.chance:

			loot.append_array(entry.loot_set.items)

	return loot