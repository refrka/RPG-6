class_name Inventory extends Resource





@export var size:= 3


@export var slots: Array[SlotData]








func get_slot_for(item_id: StringName, quantity:= 1) -> SlotData:

	for slot_data in slots:

		if slot_data._can_accept(item_id, quantity):

			return slot_data

	return null