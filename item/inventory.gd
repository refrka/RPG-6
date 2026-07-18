class_name Inventory extends Resource



signal inventory_updated(inventory: Inventory)

signal item_count_changed(item_data: ItemData, amount: int, removed: bool)


@export var item_list: Array[ItemData]





func add_item_data(item_data: ItemData) -> void:

	if !item_list.has(item_data):

		item_list.append(item_data)

		item_data.data_emptied.connect(_on_data_emptied)

		item_data.data_updated.connect(_on_data_updated)

		item_count_changed.emit(item_data, item_data.count, false)




func remove_item_data(item_data: ItemData) -> void:

	if item_list.has(item_data):

		item_list.erase(item_data)

		item_count_changed.emit(item_data, item_data.count, true)




func add_item(item_def: ItemDef, count:= 1) -> void:

	var item_data = get_data_with_def(item_def)

	if item_data:

		var new_count = item_data.count + count

		item_data.set_data(item_def, new_count)
	
	else:

		item_data = ItemData.create(item_def, count)

	item_count_changed.emit(item_data, count, false)





func remove_item(item_def: ItemDef, count:= 1) -> void:

	var item_data = get_data_with_def(item_def)

	if item_data:

		var new_count = item_data.count - count

		item_data.set_data(item_def, new_count)

		item_count_changed.emit(item_data, count, true)





func get_data_with_def(item_def: ItemDef) -> ItemData:

	for item_data in item_list:

		if item_data.def == item_def:

			return item_data

	return null








func _on_data_emptied(item_data: ItemData) -> void:

	item_list.erase(item_data)



func _on_data_updated(_item_data: ItemData) -> void:

	inventory_updated.emit(self)