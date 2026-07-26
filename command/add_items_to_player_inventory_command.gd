class_name AddItemsToPlayerInventoryCommand extends Command


@export var item_def: ItemDef

@export var item_id: StringName

@export var amount: int





func execute(_data: Dictionary = {}) -> bool:

	if _data.has("item_def"):

		item_def = _data["item_def"]

	if _data.has("item_id"):

		item_id = _data["item_id"]

	if _data.has("amount"):

		amount = _data["amount"]

	if !item_def:

		item_def = Items.get_item_def(item_id)

	var player = Game.get_player()

	player.inventory.add_items(item_def, amount)

	return true