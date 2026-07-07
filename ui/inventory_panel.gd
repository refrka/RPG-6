class_name InventoryPanel extends MarginContainer




signal item_use_requested(item_data: ItemData)






@export var inventory_list: InventoryList




func _ready() -> void:

	inventory_list.item_use_requested.connect(item_use_requested.emit)





func load_inventory(inventory: Inventory, is_player_inventory: bool) -> void:

	inventory_list.load_items(inventory.items, is_player_inventory)