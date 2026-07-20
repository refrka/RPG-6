class_name PlayerInventory extends Inventory







func equip_item_data(equipment_data: EquipmentData) -> void:

	super(equipment_data)

	var equipment_def = equipment_data.get_def()

	var equipment_type = equipment_def.equipment_type

	Events.fire(EquippedItemsChangedEvent, {"equipment_type": equipment_type, "equipment_data": equipment_data})





func unequip_item_data(equipment_type: EquipmentDef.EquipmentType) -> bool:

	if super(equipment_type):

		Events.fire(EquippedItemsChangedEvent, {"equipment_type": equipment_type, "equipment_data": null})

	return true