class_name ProfilePanel extends Overlay




@export var inventory_display: InventoryDisplay

@export var player_name_label: Label

@export var close_button: Button



@export var equipment_slots: Array[ProfileEquipmentSlot]





func _ready() -> void:

	Events.subscribe(GameStartedEvent, _on_game_started)

	Events.subscribe(GameEndedEvent, _on_game_ended)

	for slot in equipment_slots:

		slot.equip_requested.connect(_on_slot_equip_requested)

		slot.unequip_requested.connect(_on_slot_unequip_requested)

	close_button.pressed.connect(_on_close_pressed)




func load_player() -> void:

	var player = Game.get_player()

	player_name_label.text = player.get_display_name()

	inventory_display.load_inventory(player.inventory)

	player.inventory.item_equipped.connect(_on_item_equipped)

	player.inventory.item_unequipped.connect(_on_item_unequipped)




func unload_player() -> void:

	inventory_display.clear()








func _get_equipment_slot(equipment_type: EquipmentDef.EquipmentType) -> ProfileEquipmentSlot:

	for slot in equipment_slots:

		if slot.equipment_type == equipment_type:

			return slot

	return null









func _on_game_started(_event: Event) -> void:

	load_player()



func _on_game_ended(_event: Event) -> void:

	unload_player()



func _on_slot_equip_requested(slot: ProfileEquipmentSlot) -> void:

	inventory_display.filter_equipment_type(slot.equipment_type)



func _on_slot_unequip_requested(slot: ProfileEquipmentSlot) -> void:

	var player = Game.get_player()

	player.inventory.unequip_item_data(slot.equipment_data)



func _on_item_equipped(equipment_data: EquipmentData) -> void:

	var equipment_type = equipment_data.get_equipment_type()

	var slot = _get_equipment_slot(equipment_type)

	slot.set_equipment(equipment_data)



func _on_item_unequipped(equipment_data: EquipmentData) -> void:

	var equipment_type = equipment_data.get_equipment_type()

	var slot = _get_equipment_slot(equipment_type)

	slot.clear()



func _on_close_pressed() -> void:

	close_requested.emit()