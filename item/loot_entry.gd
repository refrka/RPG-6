class_name LootEntry extends Resource






@export var loot_sets: Array[LootSet]

@export var item_list: Dictionary[ItemDef, int]



func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for loot_set in loot_sets:

		if roll <= loot_set.chance:

			var _loot = loot_set.get_loot()

			for item_def in _loot:

				var count = _loot[item_def]

				if !loot.has(item_def):

					loot[item_def] = 0

				loot[item_def] += count

	return loot 