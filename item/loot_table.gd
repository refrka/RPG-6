class_name LootTable extends Resource



@export var entries: Array[LootEntry]





func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		var entry_loot = entry.get_loot(roll)

		for item_def in entry_loot:

			var count = entry_loot[item_def]

			if !loot.has(item_def):

				loot[item_def] = 0

			loot[item_def] += count

	return loot