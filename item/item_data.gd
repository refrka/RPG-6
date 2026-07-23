class_name ItemData extends Resource



signal data_updated(item_data: ItemData)

signal data_emptied(item_data: ItemData)

signal count_updated(item_data: ItemData, amount: int, added: bool)



@export var item_def: ItemDef

@export var count: int







func set_data(_item_def: ItemDef, _count:= 1) -> void:

	item_def = _item_def

	var amount = _count - count

	var added = amount > 0

	count = _count

	data_updated.emit(self)

	count_updated.emit(self, amount, added)




func add_amount(amount: int) -> void:

	count += amount

	count_updated.emit(self, amount, true)



func remove_amount(amount: int) -> void:

	count -= amount

	count_updated.emit(self, amount, false)

	if is_empty():

		data_emptied.emit(self)





func get_item_def() -> ItemDef:

	return item_def



func get_count() -> int:

	return count



func is_empty() -> bool:

	return count <= 0 or item_def == null




func merge(item_data: ItemData) -> void:

	if item_def != item_data.get_item_def():

		return

	var new_count = count + item_data.get_count()

	count = new_count

	data_updated.emit(self)

