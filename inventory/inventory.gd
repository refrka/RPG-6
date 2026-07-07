class_name Inventory extends Resource


## DEPRECATED
signal item_quantity_changed(item_id: StringName, quantity_changed: int, new_quantity: int)

signal gold_updated(quantity_changed: int, new_quantity: int)





## DEPRECATED
@export var items: Dictionary[StringName, int]

## DEPRECATED
@export var equipment: Array[ItemData]

@export var equipped_weapon: ItemData

@export var equipped_armor: ItemData

@export var equipped_accessory: ItemData

@export var gold: int









## DEPRECATED
func add_item(item_id: StringName, quantity: int, _item_data: ItemData = null) -> void:

	var item_def = Items.get_item_def(item_id)

	if item_def is EquipmentDef:

		pass

	else:

		if !items.has(item_id):

			items[item_id] = 0

		items[item_id] += quantity

		item_quantity_changed.emit(item_id, quantity, items[item_id])






## DEPRECATED
func remove_item(item_id: StringName, quantity: int) -> int:

	var remaining:= quantity

	var removed:= 0

	if items.has(item_id):

		removed = min(quantity, items[item_id])

		items[item_id] -= removed

		remaining -= removed

	var new_count = items[item_id]

	if new_count <= 0:

		items.erase(item_id)

	item_quantity_changed.emit(item_id, -removed, new_count)

	return remaining




func add_gold(amount: int) -> void:

	gold += amount

	gold_updated.emit(amount, gold)




func remove_gold(amount: int) -> void:

	gold -= amount

	gold_updated.emit(-amount, gold)





func clear() -> void:

	items.clear()

	equipment.clear()

	gold = 0





func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["items"] = {}

	for item_id in items:

		save_dict["items"][item_id] = items[item_id]

	save_dict["equipment"] = []

	for item_data in equipment:

		save_dict["equipment"].append(item_data.get_dictionary())

	save_dict["equipped_weapon"] = equipped_weapon.get_dictionary()

	save_dict["equipped_armor"] = equipped_armor.get_dictionary()

	save_dict["equipped_accessory"] = equipped_accessory.get_dictionary()

	save_dict["gold"] = gold

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> Inventory:

	var inventory = Inventory.new()

	for item_id in save_dict["items"]:

		inventory.items[item_id] = int(save_dict["items"][item_id])

	if !save_dict.has("equipped_weapon"):

		save_dict["equipped_weapon"] = {}

	if !save_dict.has("equipped_armor"):

		save_dict["equipped_armor"] = {}

	if !save_dict.has("equipped_accessory"):

		save_dict["equipped_accessory"] = {}

	for dict in save_dict["equipment"]:

		inventory.equipment.append(ItemData.load_dictionary(dict))

	inventory.equipped_weapon = ItemData.load_dictionary(save_dict["equipped_weapon"])

	inventory.equipped_armor = ItemData.load_dictionary(save_dict["equipped_armor"])

	inventory.equipped_accessory = ItemData.load_dictionary(save_dict["equipped_accessory"])

	inventory.gold = int(save_dict["gold"])

	return inventory