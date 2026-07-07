class_name LootTable extends Resource


@export var entries: Array[LootEntry]








func get_loot(roll: float) -> Array[ItemData]:

	var loot: Array[ItemData] = []

	for entry in entries:

		if roll <= entry.chance:

			loot.append_array(entry.loot_set.items)

	return loot