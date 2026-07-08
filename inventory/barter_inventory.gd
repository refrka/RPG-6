class_name BarterInventory extends Inventory





@export var buy_factor:= 1.5

@export var sell_factor:= 0.75


@export var barter_items: Array[BarterItemData]








static func load_inventory(inventory: Inventory) -> BarterInventory:

	var barter_inventory = BarterInventory.new()
	
	for item_data in inventory.get_items():

		barter_inventory.barter_items.append(BarterItemData.load_item_data(item_data))

	return barter_inventory




func get_all_items() -> Array[BarterItemData]:

	return barter_items








func get_buy_factor() -> float:

	return buy_factor





func get_sell_factor() -> float:

	return sell_factor