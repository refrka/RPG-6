class_name LootSet extends Resource


@export var chance:= 0.5

@export var item_list: Dictionary[ItemDef, Vector2i]



func get_loot() -> Dictionary[ItemDef, int]:

	var loot_list: Dictionary[ItemDef, int] = {}

	for item_def in item_list:

		var count_range = item_list[item_def]

		if count_range == Vector2i.ZERO:

			count_range = Vector2(1,1)

		var count = randi_range(count_range.x, count_range.y)

		loot_list[item_def] = count

	return loot_list