class_name PlayerInventory extends Inventory








func add_item_data(item_data: ItemData) -> void:

	super(item_data)

	Events.fire(ItemsAddedToInventoryEvent, {"item_data": item_data, "amount": item_data.get_count()})




func remove_item_data(item_data: ItemData) -> void:

	super(item_data)

	Events.fire(ItemsRemovedFromInventoryEvent, {"item_data": item_data, "amount": item_data.get_count()})






func add_item(item_def: ItemDef, amount:= 1) -> ItemData:

	var item_data = super(item_def, amount)

	Events.fire(ItemsAddedToInventoryEvent, {"item_data": item_data, "amount": amount})

	return item_data




func remove_item(item_def: ItemDef, amount:= 1) -> ItemData:

	var item_data = super(item_def, amount)

	Events.fire(ItemsRemovedFromInventoryEvent, {"item_data": item_data, "amount": amount})

	return item_data






func equip_item_data(equipment_data: EquipmentData) -> void:

	super(equipment_data)

	var equipment_def = equipment_data.get_def()

	var equipment_type = equipment_def.equipment_type

	Events.fire(EquippedItemsChangedEvent, {"equipment_type": equipment_type, "equipment_data": equipment_data})





func unequip_item_data(equipment_type: EquipmentDef.EquipmentType) -> bool:

	if super(equipment_type):

		Events.fire(EquippedItemsChangedEvent, {"equipment_type": equipment_type, "equipment_data": null})

	return true