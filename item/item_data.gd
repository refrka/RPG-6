class_name ItemData extends Resource


signal data_updated(item_data: ItemData)

signal data_emptied(item_data: ItemData)


@export var def: ItemDef

@export var count: int







func set_data(_def: ItemDef, _count:= 1) -> void:

	def = _def

	count = _count

	data_updated.emit(self)

	if is_empty():

		data_emptied.emit(self)




func remove_amount(amount: int) -> void:

	count -= amount

	data_updated.emit(self)

	if is_empty():

		data_emptied.emit(self)





func absorb(item_data: ItemData) -> void:

	var new_count = count + item_data.count

	set_data(def, new_count)

	item_data.set_data(null)





func get_display_name() -> String:

	return def.display_name



func get_def() -> ItemDef:

	return def


func get_count() -> int:

	return count





func is_empty() -> bool:

	return def == null or count <= 0





static func create(_def: ItemDef, _count:= 1) -> ItemData:

	var item_data = ItemData.new()

	item_data.set_data(_def, _count)

	return item_data







func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = def.item_id

	save_dict["count"] = count

	return save_dict




static func load_dictionary(save_dict: Dictionary) -> ItemData:

	var item_data = ItemData.new()

	var item_def = Items.get_item_def(save_dict["item_id"])

	item_data.def = item_def

	item_data.count = int(save_dict["count"])

	return item_data