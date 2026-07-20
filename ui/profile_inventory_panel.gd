class_name ProfileInventoryPanel extends MarginContainer


@export var weapon_item_row: EquipmentItemRow

@export var no_weapon_label: Label

@export var armor_item_row: EquipmentItemRow

@export var no_armor_label: Label

@export var accessory_item_row: EquipmentItemRow

@export var no_accessory_label: Label

@export var inventory_list: InventoryList





func _ready() -> void:

	Events.subscribe(EquippedItemsChangedEvent, _on_equipped_items_changed)

	inventory_list.discard_requested.connect(_on_discard_requested)




func load_player_inventory() -> void:

	var player = Game.get_player()

	inventory_list.load_inventory(player.inventory)

	_update_all_equipment_rows()





func clear_player_inventory() -> void:

	inventory_list.clear_inventory()

	weapon_item_row.hide()

	no_weapon_label.show()

	armor_item_row.hide()

	no_armor_label.show()

	accessory_item_row.hide()

	no_accessory_label.show()




func _update_all_equipment_rows() -> void:

	for type in [EquipmentDef.EquipmentType.WEAPON, EquipmentDef.EquipmentType.ARMOR, EquipmentDef.EquipmentType.ACCESSORY]:

		_update_equipment_row(type)




func _update_equipment_row(type: EquipmentDef.EquipmentType) -> void:

	var player = Game.get_player()

	var item_data: ItemData = null

	match type:

		EquipmentDef.EquipmentType.WEAPON:

			if !player.inventory.equipped_items.has(type):

				no_weapon_label.show()

				weapon_item_row.hide()

			else:

				no_weapon_label.hide()

				weapon_item_row.show()

				item_data = player.inventory.equipped_items[type]

			weapon_item_row.set_row_data(item_data)

		EquipmentDef.EquipmentType.ARMOR:

			if !player.inventory.equipped_items.has(type):

				no_armor_label.show()

				armor_item_row.hide()

			else:

				no_armor_label.hide()

				armor_item_row.show()

				item_data = player.inventory.equipped_items[type]

			armor_item_row.set_row_data(item_data)

		EquipmentDef.EquipmentType.ACCESSORY:

			if !player.inventory.equipped_items.has(type):

				no_accessory_label.show()

				accessory_item_row.hide()

			else:

				no_accessory_label.hide()

				accessory_item_row.show()

				item_data = player.inventory.equipped_items[type]

			accessory_item_row.set_row_data(item_data)



func _on_discard_requested(item_data: ItemData, amount: int) -> void:

	item_data.remove_amount(amount)




func _on_equipped_items_changed(event: Event) -> void:

	var equipment_type = event.data["equipment_type"]

	_update_equipment_row(equipment_type)




func _activate() -> void:

	visible = true




func _deactivate() -> void:

	visible = false




