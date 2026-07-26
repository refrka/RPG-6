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


func get_display_name() -> String:

	if item_def.display_name == "":

		return item_def.item_id.replace("_", " ")

	return item_def.display_name


func get_description() -> String:

	return item_def.description


func get_item_id() -> StringName:

	return item_def.item_id








func is_empty() -> bool:

	return count <= 0 or item_def == null




func merge(item_data: ItemData) -> void:

	if item_def != item_data.get_item_def():

		return

	var new_count = count + item_data.get_count()

	count = new_count

	data_updated.emit(self)






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = item_def.item_id

	save_dict["count"] = count

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> ItemData:

	var item_data = ItemData.new()

	var _item_def = Items.get_item_def(save_dict["item_id"])

	var _count = int(save_dict["count"])

	item_data.item_def = _item_def

	item_data.count = _count

	return item_data