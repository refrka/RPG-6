class_name LootTable extends Resource


@export var entries: Array[LootEntry]








func get_loot(roll: float) -> Dictionary[StringName, int]:

	var loot: Dictionary[StringName, int] = {}

	for entry in entries:

		if roll <= entry.chance:

			loot.merge(entry.loot_set.items)

	return loot