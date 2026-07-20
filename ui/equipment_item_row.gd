class_name EquipmentItemRow extends InventoryItemRow




signal equip_requested(row: InventoryItemRow)

signal unequip_requested(row: InventoryItemRow)




@export var equip_button: Button

@export var unequip_button: Button





func _ready() -> void:

	super()

	equip_button.pressed.connect(equip_requested.emit.bind(self))

	unequip_button.pressed.connect(unequip_requested.emit.bind(self))



func set_row_data(_item_data: ItemData) -> void:

	super(_item_data)

	equip_button.hide()

	unequip_button.show()

	discard_button.hide()

