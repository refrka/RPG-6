class_name LootTable extends Resource



@export var entries: Array[LootEntry]





func get_loot() -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		var entry_loot = entry.get_loot(randf())

		for item_def in entry_loot:

			var count = entry_loot[item_def]

			if !loot.has(item_def):

				loot[item_def] = 0

			loot[item_def] += count

		for item_def in entry.item_list:

			print("here's a fucking item def duuuurrr")

			var count = entry.item_list[item_def]

			if !loot.has(item_def):

				loot[item_def] = 0

			loot[item_def] += count

	return loot