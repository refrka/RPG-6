class_name EquipmentItemRow extends InventoryItemRow






func set_row_data(_item_data: ItemData) -> void:

	super(_item_data)

	equip_button.hide()

	unequip_button.show()

	discard_button.hide()