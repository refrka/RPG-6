class_name ProfileInventoryPanel extends MarginContainer




@export var inventory_list: InventoryList



func _ready() -> void:

	inventory_list.discard_requested.connect(_on_discard_requested)




func load_player_inventory() -> void:

	var player = Game.get_player()

	inventory_list.load_inventory(player.inventory)




func _on_discard_requested(item_data: ItemData, amount: int) -> void:

	item_data.remove_amount(amount)



func _activate() -> void:

	visible = true




func _deactivate() -> void:

	visible = false




