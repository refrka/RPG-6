class_name Inventory extends Resource



signal inventory_updated(inventory: Inventory)

signal item_count_changed(item_data: ItemData, amount: int, removed: bool)


@export var item_list: Array[ItemData]

@export var equipped_items: Dictionary[EquipmentDef.EquipmentType, EquipmentData]






func add_item_data(item_data: ItemData) -> void:

	if !item_list.has(item_data):

		item_list.append(item_data)

		item_data.data_emptied.connect(_on_data_emptied)

		item_data.data_updated.connect(_on_data_updated)

		print("add_item_data() emitting")

		item_count_changed.emit(item_data, item_data.count, false)




func remove_item_data(item_data: ItemData) -> void:

	if item_list.has(item_data):

		item_list.erase(item_data)

		item_count_changed.emit(item_data, item_data.count, true)




func add_item(item_def: ItemDef, amount:= 1) -> ItemData:

	var item_data = get_data_with_def(item_def)

	print("def and data: ", item_def, "/", item_data)

	if item_data:

		var new_count = item_data.count + amount

		item_data.set_data(item_def, new_count)

		print("add_item() emitting")

		item_count_changed.emit(item_data, amount, false)
	
	else:

		item_data = ItemData.create(item_def, amount)

		add_item_data(item_data)

	return item_data





func remove_item(item_def: ItemDef, amount:= 1) -> ItemData:

	var item_data = get_data_with_def(item_def)

	if item_data:

		var new_count = item_data.count - amount

		item_data.set_data(item_def, new_count)

		item_count_changed.emit(item_data, amount, true)

	return item_data





func clear_inventory() -> void:

	item_list.clear()

	equipped_items.clear()





func can_equip(equipment_data: EquipmentData) -> bool:

	return true






func equip_item_data(equipment_data: EquipmentData) -> void:

	var equipment_def = equipment_data.get_def()

	var equipment_type = equipment_def.equipment_type

	if get_equipment_data(equipment_type) != null:

		unequip_item_data(equipment_type)

	equipped_items[equipment_type] = equipment_data

	if has_item_data(equipment_data):

		remove_item_data(equipment_data)





func unequip_item_data(equipment_type: EquipmentDef.EquipmentType) -> bool:

	var equipment_data = get_equipment_data(equipment_type)

	if equipment_data == null:

		return false

	add_item_data(equipment_data)

	equipped_items.erase(equipment_type)

	return true






func get_equipment_data(equipment_type: EquipmentDef.EquipmentType) -> EquipmentData:

	if equipped_items.has(equipment_type):

		return equipped_items[equipment_type]

	return null



func get_data_with_def(item_def: ItemDef) -> ItemData:

	for item_data in item_list:

		if item_data.def == item_def:

			return item_data

	return null



func has_item_data(item_data: ItemData) -> bool:

	return item_list.has(item_data)



func is_item_data_equipped(item_data: ItemData) -> bool:

	if not item_data is EquipmentData:

		return false

	var item_def = item_data.get_def()

	var equipment_type = item_def.equipment_type

	if get_equipment_data(equipment_type) == item_data:

		return true

	return false





func _on_data_emptied(item_data: ItemData) -> void:

	item_list.erase(item_data)



func _on_data_updated(_item_data: ItemData) -> void:

	inventory_updated.emit(self)















func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_list"] = []

	for item_data in item_list:

		save_dict["item_list"].append(item_data.get_dictionary())

	return save_dict






func load_dictionary(save_dict: Dictionary) -> void:

	clear_inventory()

	for dict in save_dict["item_list"]:

		var item_data = ItemData.load_dictionary(dict)

		item_data.data_emptied.connect(_on_data_emptied)

		item_data.data_updated.connect(_on_data_updated)

		item_list.append(item_data)