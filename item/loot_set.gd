class_name LootSet extends Resource


@export var chance:= 0.5

@export var item_list: Dictionary[ItemDef, int]



func get_loot() -> Dictionary[ItemDef, int]:

	return item_list