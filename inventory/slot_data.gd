class_name SlotData extends Resource


signal slot_updated(slot_data: SlotData)


@export var item_id: StringName

@export var item_data: ItemData

@export var quantity:= 0






func set_data(_item_id: StringName, _quantity: int, _item_data: ItemData = null) -> void:

	item_id = _item_id

	quantity = _quantity

	if is_empty():

		clear_data()

	slot_updated.emit(self)





func clear_data() -> void:

	item_id = &""

	quantity = 0





func is_empty() -> bool:

	if item_id == &"" or quantity <= 0:

		return true

	return false







func _can_accept(_item_id: StringName, _quantity: int, _item_data: ItemData = null) -> bool:

	if is_empty():

		return true

	if _item_data != null:

		return false

	if item_id != _item_id:

		return false

	return true








func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = item_id

	if item_data:

		save_dict["item_data"] = item_data.get_dictionary()

	save_dict["quantity"] = quantity

	return save_dict







static func _load_dictionary(save_dict: Dictionary) -> SlotData:

	var slot_data = SlotData.new()

	slot_data.item_id = save_dict["item_id"]

	if save_dict.has("item_data"):

		slot_data.item_data = ItemData.load_dictionary(save_dict["item_data"])

	slot_data.quantity = int(save_dict["quantity"])

	return slot_data