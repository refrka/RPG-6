class_name Inventory extends Resource


signal item_data_updated(item_data: ItemData)

signal item_data_added(item_data: ItemData)

signal item_data_removed(item_data: ItemData)

signal item_equipped(equipment_data: EquipmentData)

signal item_unequipped(equipment_data: EquipmentData)

signal gold_count_changed(amount: int, new_count: int, added: bool)



@export var item_list: Array[ItemData]

@export var equipment_slots: Dictionary[EquipmentDef.EquipmentType, EquipmentData]

@export var gold_count: int



func _initialize() -> void:

	for item_data in item_list:

		_connect_item_data(item_data)

	equipment_slots[EquipmentDef.EquipmentType.WEAPON] = null

	equipment_slots[EquipmentDef.EquipmentType.ARMOR] = null

	equipment_slots[EquipmentDef.EquipmentType.ACCESSORY] = null




func clear() -> void:

	item_list.clear()
	
	gold_count = 0

	for equipment_type in equipment_slots:

		equipment_slots[equipment_type] = null




## If this method calls merge(), new_item_data is emptied and the method returns false
func add_data(new_item_data: ItemData) -> bool:

	var item_def = new_item_data.get_item_def()
	
	var item_data = get_item_data_with_def(item_def)

	if !item_data:

		_connect_item_data(new_item_data)

		_add_item_data(new_item_data)

		return true

	else:

		item_data.merge(new_item_data)

		return false




func remove_data(old_item_data: ItemData) -> void:

	if !item_list.has(old_item_data):

		var item_data = get_item_data_with_def(old_item_data.get_item_def())

		if item_data:

			item_data.remove_amount(old_item_data.get_count())

	else:

		_remove_item_data(old_item_data)




func add_items(item_def: ItemDef, amount:= 1) -> void:

	var item_data = get_item_data_with_def(item_def)

	if !item_data:

		item_data = Items.create_item_data(item_def)

		_connect_item_data(item_data)

		item_data.set_data(item_def, amount)

		_add_item_data(item_data)

	else:

		item_data.add_amount(amount)
	



func remove_items(item_def: ItemDef, amount:= 1) -> void:

	var item_data = get_item_data_with_def(item_def)

	if !item_data:

		return
	
	item_data.remove_amount(amount)




func add_gold(amount: int) -> void:

	gold_count += amount

	gold_count_changed.emit(amount, gold_count, true)




func remove_gold(amount: int) -> void:

	var removed = amount

	if amount > gold_count:

		removed = gold_count

	gold_count = max(0, gold_count - amount)

	gold_count_changed.emit(removed, gold_count, false)




func equip_item_data(equipment_data: EquipmentData) -> void:

	var equipment_type = equipment_data.get_equipment_type()

	var equipped_data = get_equipment(equipment_type)

	if equipped_data:

		if equipped_data == equipment_data:

			return

		unequip_item_data(equipped_data)

	equipment_slots[equipment_type] = equipment_data

	item_equipped.emit(equipment_data)




func unequip_item_data(equipment_data: EquipmentData) -> void:

	var equipment_type = equipment_data.get_equipment_type()

	var equipped_data = get_equipment(equipment_type)

	if equipment_data == equipped_data:

		equipment_slots[equipment_type] = null

		item_unequipped.emit(equipment_data)




func transfer_item_data_to(item_data: ItemData, inventory: Inventory, amount:= -1) -> void:

	if amount == -1:

		inventory.add_data(item_data)

		remove_data(item_data)

	else:

		var transferred_data = Items.create_item_data(item_data.get_item_def(), amount)

		inventory.add_data(transferred_data)

		remove_items(item_data.get_item_def(), amount)






func transfer_gold_to(amount: int, inventory: Inventory) -> void:

	inventory.add_gold(amount)

	remove_gold(amount)














func get_item_data_with_def(item_def: ItemDef) -> ItemData:

	for item_data in item_list:

		if item_data.get_item_def() == item_def:

			return item_data

	return null



func get_equipment(equipment_type: EquipmentDef.EquipmentType) -> EquipmentData:

	return equipment_slots[equipment_type]



func get_gold_count() -> int:

	return gold_count



func is_item_data_equipped(equipment_data: EquipmentData) -> bool:

	var equipment_type = equipment_data.get_equipment_type()

	if get_equipment(equipment_type) == equipment_data:

		return true

	return false













func _add_item_data(item_data: ItemData) -> void:

	item_list.append(item_data)

	item_data_added.emit(item_data)




func _remove_item_data(item_data: ItemData) -> void:

	item_list.erase(item_data)

	item_data_removed.emit(item_data)




func _connect_item_data(item_data: ItemData) -> void:

	item_data.data_updated.connect(_on_item_data_updated)

	item_data.count_updated.connect(_on_item_data_count_updated)

	item_data.data_emptied.connect(_on_item_data_emptied)



func _disconnect_item_data(item_data: ItemData) -> void:

	item_data.data_updated.disconnect(_on_item_data_updated)

	item_data.count_updated.disconnect(_on_item_data_count_updated)

	item_data.data_emptied.disconnect(_on_item_data_emptied)



func _on_item_data_updated(item_data: ItemData) -> void:

	item_data_updated.emit(item_data)



func _on_item_data_count_updated(item_data: ItemData, _amount: int, _added: bool) -> void:

	item_data_updated.emit(item_data)



func _on_item_data_emptied(item_data: ItemData) -> void:

	if item_data is EquipmentData and is_item_data_equipped(item_data):

		unequip_item_data(item_data)

	item_data_updated.emit(item_data)

	_disconnect_item_data(item_data)

	_remove_item_data(item_data)









func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_list"] = []

	for item_data in item_list:

		save_dict["item_list"].append(item_data.get_dictionary())

	save_dict["gold_count"] = gold_count

	return save_dict





func load_dictionary(save_dict: Dictionary) -> void:

	clear()

	for dict in save_dict["item_list"]:

		var item_data = ItemData.load_dictionary(dict)

		_connect_item_data(item_data)

		item_list.append(item_data)

	gold_count = int(save_dict["gold_count"])