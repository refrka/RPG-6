class_name LootEntry extends Resource






@export var loot_sets: Array[LootSet]

@export var item_list: Dictionary[ItemDef, int]



func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for loot_set in loot_sets:

		if roll <= loot_set.chance:

			for item_def in loot_set.item_list:

				var count = loot_set.item_list[item_def]

				if !loot.has(item_def):

					loot[item_def] = 0

				loot[item_def] += count

	return loot 