class_name LootTable extends Resource



@export var entries: Array[LootEntry]





func get_loot() -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		print("looting entry")

		var entry_loot = entry.get_loot(randf())

		print("entry loot: ", entry_loot)

		for item_def in entry_loot:

			var count = entry_loot[item_def]

			if !loot.has(item_def):

				loot[item_def] = 0

			loot[item_def] += count

		for item_def in entry.item_list:

			var count = entry.item_list[item_def]

			if !loot.has(item_def):

				loot[item_def] = 0

			loot[item_def] += count

	return loot