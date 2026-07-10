class_name ItemData extends Resource


signal count_updated(amount: int, item_data: ItemData, removed: bool)

signal data_set

signal data_emptied


# Represents a unique instance of this object for a single item
var data_id: StringName


@export var def: ItemDef


@export var count:= 1




func set_data(_def: ItemDef, _count: int) -> void:

	def = _def

	count = _count

	data_set.emit()





func get_item_id() -> StringName:

	return def.item_id



func get_data_id() -> StringName:

	return data_id



func get_def() -> ItemDef:

	return def



func get_count() -> int:

	return count









func add_count(amount: int) -> void:

	count += amount

	count_updated.emit(amount, self, false)





func remove_count(amount: int) -> void:

	count = max(0, count - amount)

	if count == 0:

		data_emptied.emit()

	count_updated.emit(amount, self, true)









func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = def.item_id

	save_dict["data_id"] = data_id

	save_dict["count"] = count

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> ItemData:

	var item_data = ItemData.new()

	item_data.def = Items.get_item_def(save_dict["item_id"])

	item_data.data_id = save_dict["data_id"]

	item_data.count = int(save_dict["count"])

	return item_data


