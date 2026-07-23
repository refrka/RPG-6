class_name PlayerInventory extends Inventory









func _on_item_data_count_updated(item_data: ItemData, amount: int, added: bool) -> void:

	super(item_data, amount, added)

	if added:

		Events.fire(PlayerAddedItemsEvent, {"item_data": item_data, "amount": amount}, true)

	else:

		Events.fire(PlayerRemovedItemsEvent, {"item_data": item_data, "amount": amount}, true)