class_name Inventory extends Resource





@export var slots: Array[SlotData]






func add_item(item_id: StringName, quantity: int, item_data: ItemData = null) -> void:
	
	var slot_data = get_slot_for(item_id, quantity, item_data)

	var new_count = slot_data.quantity + quantity

	slot_data.set_data(item_id, new_count, item_data)





func remove_item(item_id: StringName, quantity: int) -> int:

	var slot_data = get_first_slot_with(item_id)

	var quantity_removed = 0

	while quantity_removed < quantity and slot_data != null:

		quantity_removed = min(quantity, slot_data.quantity)

		var new_count = slot_data.quantity - quantity_removed

		slot_data.set_data(item_id, new_count)

		slot_data = get_first_slot_with(item_id)

	var remaining = quantity - quantity_removed

	return remaining






func get_slot_for(item_id: StringName, quantity: int, item_data: ItemData) -> SlotData:

	for slot_data in slots:

		if slot_data._can_accept(item_id, quantity, item_data):

			return slot_data

	var slot_data = SlotData.new()

	slots.append(slot_data)

	return slot_data




func get_first_slot_with(item_id: StringName) -> SlotData:

	for slot_data in slots:
		
		if slot_data.item_id == item_id:

			return slot_data

	return null






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["slots"] = []

	for slot_data in slots:

		save_dict["slots"].append(slot_data._get_dictionary())

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> Inventory:

	var inventory = Inventory.new()

	for dict in save_dict["slots"]:

		inventory.slots.append(SlotData._load_dictionary(dict))

	return inventory