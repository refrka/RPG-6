class_name Inventory extends Resource


signal item_data_updated(item_data: ItemData)

signal item_data_added(item_data: ItemData)

signal item_data_removed(item_data: ItemData)



@export var item_list: Array[ItemData]












func add_data(new_item_data: ItemData) -> void:

	var item_def = new_item_data.get_item_def()
	
	var item_data = get_item_data_with_def(item_def)

	if !item_data:

		_add_item_data(item_data)

	else:

		item_data.merge(new_item_data)




func remove_data(old_item_data: ItemData) -> void:

	if !item_list.has(old_item_data):

		return

	_remove_item_data(old_item_data)




func add_items(item_def: ItemDef, count:= 1) -> void:

	var item_data = get_item_data_with_def(item_def)

	if !item_data:

		item_data = Items.create_item_data(item_def, count)

	_add_item_data(item_data)











func get_item_data_with_def(item_def: ItemDef) -> ItemData:

	for item_data in item_list:

		if item_data.get_item_def() == item_def:

			return item_data

	return null








func _add_item_data(item_data: ItemData) -> void:

	item_list.append(item_data)

	item_data.data_updated.connect(_on_item_data_updated)

	item_data.count_updated.connect(_on_item_data_count_updated)

	item_data.data_emptied.connect(_on_item_data_emptied)

	item_data_added.emit(item_data)



func _remove_item_data(item_data: ItemData) -> void:

	item_list.erase(item_data)

	item_data_removed.emit(item_data)






func _on_item_data_updated(item_data: ItemData) -> void:

	item_data_updated.emit(item_data)



func _on_item_data_count_updated(item_data: ItemData, _amount: int, _added: bool) -> void:

	item_data_updated.emit(item_data)



func _on_item_data_emptied(item_data: ItemData) -> void:

	item_data_updated.emit(item_data)

	_remove_item_data(item_data)