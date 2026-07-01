class_name Inventory extends Resource


signal inventory_updated(item_id: StringName, new_quantity: int)



@export var items: Dictionary[StringName, int]

@export var equipment: Dictionary[StringName, ItemData]

@export var gold: int




func add_item(item_id: StringName, quantity: int, item_data: ItemData = null) -> void:

	if items.has(item_id):

		items[item_id] += quantity

	inventory_updated.emit(item_id, items[item_id])






func remove_item(item_id: StringName, quantity: int) -> int:

	var remaining:= quantity

	if items.has(item_id):

		var removed = min(quantity, items[item_id])

		items[item_id] -= removed

		remaining -= removed

	var new_count = items[item_id]

	if new_count <= 0:

		items.erase(item_id)

	inventory_updated.emit(item_id, new_count)

	return remaining





func clear() -> void:

	items.clear()

	equipment.clear()

	gold = 0





func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["items"] = {}

	for item_id in items:

		save_dict["items"][item_id] = items[item_id]

	save_dict["gold"] = gold

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> Inventory:

	var inventory = Inventory.new()

	for item_id in save_dict["items"]:

		inventory.items[item_id] = int(save_dict["items"][item_id])

	inventory.gold = int(save_dict["gold"])

	return inventory