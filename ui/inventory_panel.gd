class_name InventoryPanel extends MarginContainer









@export var inventory_list: InventoryList








func load_inventory(inventory: Inventory) -> void:

	inventory_list.load_inventory(inventory)