class_name PlayerInventory extends Inventory



signal new_item_list_updated(item_data: ItemData)



var new_item_list: Array[ItemData]







func add_data(item_data: ItemData) -> bool:

	var added = super(item_data)

	new_item_list.append(item_data)

	new_item_list_updated.emit(item_data)

	return added





func _on_item_data_count_updated(item_data: ItemData, amount: int, added: bool) -> void:

	super(item_data, amount, added)

	if added:

		new_item_list.append(item_data)

		Events.fire(PlayerAddedItemsEvent, {"item_data": item_data, "amount": amount}, true)

	else:

		Events.fire(PlayerRemovedItemsEvent, {"item_data": item_data, "amount": amount}, true)










func get_dictionary() -> Dictionary:

	var save_dict = super()

	save_dict["new_item_list"] = []

	for item_data in new_item_list:

		save_dict["new_item_list"].append(item_data.get_dictionary())

	return save_dict





func load_dictionary(save_dict: Dictionary) -> void:

	super(save_dict)

	for dict in save_dict["new_item_list"]:

		var item_def = Items.get_item_def(dict["item_id"])

		var item_data = get_item_data_with_def(item_def)

		new_item_list.append(item_data)