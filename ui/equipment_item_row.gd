class_name EquipmentItemRow extends InventoryItemRow


signal equip_requested(row: EquipmentItemRow)

signal unequip_requested(row: EquipmentItemRow)


@export var equip_button: Button

@export var unequip_button: Button





func _ready() -> void:

	super()

	equip_button.pressed.connect(_on_equip_pressed)

	unequip_button.pressed.connect(_on_unequip_pressed)




func set_equipped(state: bool) -> void:

	if state == true:

		equip_button.hide()

		unequip_button.show()

	else:

		equip_button.show()

		unequip_button.hide()




func _on_equip_pressed() -> void:

	equip_requested.emit(self)


func _on_unequip_pressed() -> void:

	unequip_requested.emit(self)