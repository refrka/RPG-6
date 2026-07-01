class_name SlotData extends Resource


signal slot_updated(slot_data: SlotData)


@export var item_id: StringName

@export var quantity:= 0






func set_data(_item_id: StringName, _quantity: int) -> void:

	item_id = _item_id

	quantity = _quantity

	slot_updated.emit(self)






func is_empty() -> bool:

	if item_id == &"" or quantity <= 0:

		return true

	return false







func _can_accept(_item_id: StringName, _quantity:= 1) -> bool:

	if is_empty():

		return true

	if item_id != _item_id:

		return false

	return true