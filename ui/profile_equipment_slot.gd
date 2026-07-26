class_name ProfileEquipmentSlot extends MarginContainer


signal unequip_requested(slot: ProfileEquipmentSlot)

signal equip_requested(slot: ProfileEquipmentSlot)



@export var equipment_type: EquipmentDef.EquipmentType

@export var equipment_name_label: Label

@export var equipment_texture: TextureRect

@export var unequip_button: Button

@export var equip_button: Button


var equipment_data: EquipmentData



func _ready() -> void:

	unequip_button.pressed.connect(_on_unequip_pressed)

	equip_button.pressed.connect(_on_equip_pressed)

	unequip_button.hide()






func set_equipment(_equipment_data: EquipmentData) -> void:

	equipment_data = _equipment_data

	equipment_name_label.text = equipment_data.get_display_name()

	unequip_button.show()

	equip_button.hide()






func clear() -> void:

	equipment_texture.texture = null

	equipment_name_label.text = ""

	unequip_button.hide()

	equip_button.show()





func _on_unequip_pressed() -> void:

	unequip_requested.emit(self)





func _on_equip_pressed() -> void:

	equip_requested.emit(self)