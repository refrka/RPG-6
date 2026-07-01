class_name Inventory extends Resource





@export var size:= 3


@export var slots: Array[SlotData]








func get_slot_for(item_id: StringName, quantity:= 1) -> SlotData:

	for slot_data in slots:

		if slot_data._can_accept(item_id, quantity):

			return slot_data

	return null








func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["slots"] = []

	for slot_data in slots:

		save_dict["slots"].append(slot_data._get_dictionary())

	return save_dict






func load_dictionary(save_dict: Dictionary) -> Inventory:

	for dict in save_dict["slots"]:

		slots.append(SlotData._load_dictionary(dict))

	return self