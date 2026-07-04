class_name InventoryPanel extends MarginContainer









@export var inventory_list: InventoryList








func load_inventory(inventory: Inventory, is_barter:= false, is_player_inventory:= true) -> void:

	inventory_list.load_inventory(inventory, is_barter, is_player_inventory)