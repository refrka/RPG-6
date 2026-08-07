class_name InventoryDisplay extends MarginContainer


signal buy_requested

signal sell_requested

signal item_data_seen(item_data: ItemData)


@onready var inventory_item_row_scene:= preload("res://ui/inventory_item_row.tscn")

@onready var equipment_item_row_scene:= preload("res://ui/equipment_item_row.tscn")

@onready var barter_item_row_scene:= preload("res://ui/barter_item_row.tscn")


@export var is_barter_inventory:= false

@export var is_player_side:= true


@export var item_list: VBoxContainer

@export var filter_entry: LineEdit

@export var reset_button: Button

@export var gold_count_label: Label



var active:= false

var inventory: Inventory

var item_row_registry: Dictionary[ItemData, InventoryItemRow]

var selected_row: InventoryItemRow






func _ready() -> void:

	filter_entry.text_changed.connect(_on_filter_text_changed)

	reset_button.pressed.connect(_on_reset_pressed)













func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	_connect_inventory_signals()

	_load_item_list()





func clear() -> void:

	_clear_item_list()

	_disconnect_inventory_signals()

	inventory = null

	item_row_registry.clear()

	selected_row = null




func refresh() -> void:

	_load_item_list()

	_update_gold_count_label()




func sleep() -> void:

	for row in item_row_registry.values():

		row.sleep()



func wake() -> void:

	for row in item_row_registry.values():

		row.wake()








func filter_equipment_type(equipment_type: EquipmentDef.EquipmentType) -> void:

	var items = inventory.item_list.duplicate()

	items = items.filter(_filter_equipment_type.bind(equipment_type))

	for item_data in item_row_registry:

		var row = item_row_registry[item_data]

		if items.has(item_data):

			row.show()

		else:

			row.hide()

			if row == selected_row:

				_deselect_row(row)
















func _load_item_list() -> void:

	_clear_item_list()

	var items = inventory.item_list.duplicate()

	items.sort_custom(_sort_alphabetical)

	for item_data in items:

		_add_item_row(item_data)

	_sort_items_alphabetical()




func _add_item_row(item_data: ItemData) -> InventoryItemRow:

	var row: InventoryItemRow = null

	if is_barter_inventory:

		row = barter_item_row_scene.instantiate() as BarterItemRow

		row.buy_requested.connect(_on_buy_requested)

		row.sell_requested.connect(_on_sell_requested)

		row.set_barter_side(is_player_side)

	else:

		match item_data.get_script():

			EquipmentData:

				row = equipment_item_row_scene.instantiate() as EquipmentItemRow

				row.equip_requested.connect(_on_equip_requested)

				row.unequip_requested.connect(_on_unequip_requested)

				row.set_equipped(inventory.is_item_data_equipped(item_data))

			_:

				row = inventory_item_row_scene.instantiate() as InventoryItemRow

		row.discard_requested.connect(_on_discard_requested)

		row.use_requested.connect(_on_use_requested)

	row.load_item_data(item_data)

	row.row_selected.connect(_on_row_selected)

	row.row_seen.connect(_on_row_seen)

	item_row_registry[item_data] = row

	item_list.add_child(row)

	if inventory is PlayerInventory:

		if inventory.new_item_list.has(item_data):

			row.set_seen_state(false)

	return row




func _remove_item_row(item_data: ItemData) -> void:

	if !item_row_registry.has(item_data):

		return

	var row = item_row_registry[item_data]

	row.queue_free()






func _update_gold_count_label() -> void:

	gold_count_label.text = str(inventory.get_gold_count())



func _select_row(row: InventoryItemRow) -> void:

	if selected_row:

		_deselect_row(selected_row)

	selected_row = row

	row.select()




func _deselect_row(row: InventoryItemRow) -> void:

	if row == selected_row:
	
		row.deselect()

		selected_row = null




func _show_all_rows() -> void:

	for row in item_row_registry.values():

		row.show()




func _filter_item_name(item_name: String) -> void:

	if item_name == "":

		_show_all_rows()

	else:

		item_name = item_name.strip_edges()

		for item_data in item_row_registry:

			var row = item_row_registry[item_data]

			if item_data.get_display_name().to_lower().contains(item_name.to_lower()):

				row.show()

			else:

				row.hide()

				if row == selected_row:

					_deselect_row(row)



func _filter_equipment_type(item_data: ItemData, equipment_type: EquipmentDef.EquipmentType) -> bool:

	if not item_data is EquipmentData:

		return false

	return item_data.get_equipment_type() == equipment_type




func _sort_alphabetical(item_data_a: ItemData, item_data_b: ItemData) -> bool:

	return item_data_a.get_display_name().to_lower() < item_data_b.get_display_name().to_lower()



func _sort_items_alphabetical() -> void:

	var items = item_row_registry.keys().duplicate()

	items.sort_custom(_sort_alphabetical)

	for item_data in items:

		var row = item_row_registry[item_data]

		var index = items.find(item_data)

		item_list.move_child(row, index)




func _clear_item_list() -> void:

	for row in item_list.get_children():

		row.queue_free()








func _connect_inventory_signals() -> void:

	inventory.item_data_added.connect(_on_item_data_added)

	inventory.item_data_removed.connect(_on_item_data_removed)

	inventory.item_equipped.connect(_on_item_equipped)

	inventory.item_unequipped.connect(_on_item_unequipped)

	inventory.gold_count_changed.connect(_on_gold_count_changed)

	if inventory is PlayerInventory:

		inventory.new_item_list_updated.connect(_on_player_new_item_list_updated)





func _disconnect_inventory_signals() -> void:

	if !inventory:

		return

	if inventory.item_data_added.is_connected(_on_item_data_added):

		inventory.item_data_added.disconnect(_on_item_data_added)

	if inventory.item_data_removed.is_connected(_on_item_data_removed):

		inventory.item_data_removed.disconnect(_on_item_data_removed)

	if inventory.item_equipped.is_connected(_on_item_equipped):

		inventory.item_equipped.disconnect(_on_item_equipped)

	if inventory.item_unequipped.is_connected(_on_item_unequipped):

		inventory.item_unequipped.disconnect(_on_item_unequipped)

	if inventory.gold_count_changed.is_connected(_on_gold_count_changed):

		inventory.gold_count_changed.disconnect(_on_gold_count_changed)

	if inventory is PlayerInventory:

		inventory.new_item_list_updated.disconnect(_on_player_new_item_list_updated)













func _on_row_selected(row: InventoryItemRow) -> void:

	_select_row(row)



func _on_row_seen(row: InventoryItemRow) -> void:

	item_data_seen.emit(row.item_data)



func _on_discard_requested(row: InventoryItemRow) -> void:

	var count_selector = UI.show_count_selector(0, row.item_data.get_count(), "Discarding %s" % row.item_data.get_display_name(), false)

	count_selector.count_submitted.connect(_on_discard_count_submitted.bind(row.item_data))



func _on_equip_requested(row: EquipmentItemRow) -> void:

	inventory.equip_item_data(row.item_data)



func _on_unequip_requested(row: EquipmentItemRow) -> void:

	inventory.unequip_item_data(row.item_data)





func _on_discard_count_submitted(count: int, item_data: ItemData) -> void:

	item_data.remove_amount(count)



func _on_filter_text_changed(text: String) -> void:

	_filter_item_name(text)




func _on_item_equipped(equipment_data: ItemData) -> void:

	if !active:

		return

	if item_row_registry.has(equipment_data):

		var row = item_row_registry[equipment_data]

		row.set_equipped(true)




func _on_item_unequipped(equipment_data: ItemData) -> void:

	if !active:

		return

	if item_row_registry.has(equipment_data):

		var row = item_row_registry[equipment_data]

		if row is EquipmentItemRow:

			row.set_equipped(false)



func _on_item_data_added(item_data: ItemData) -> void:

	_add_item_row(item_data)

	_sort_items_alphabetical()



func _on_item_data_removed(item_data: ItemData) -> void:

	if !active: 

		return

	var row = item_row_registry[item_data]

	row.queue_free()

	item_row_registry.erase(item_data)



func _on_reset_pressed() -> void:

	filter_entry.clear()

	_show_all_rows()

	if selected_row:

		_deselect_row(selected_row)



func _on_buy_requested(row: BarterItemRow) -> void:

	buy_requested.emit(row.item_data)


func _on_sell_requested(row: BarterItemRow) -> void:

	sell_requested.emit(row.item_data)



func _on_use_requested(row: InventoryItemRow) -> void:

	var item_data = row.item_data

	var player = Game.get_player()

	player.use_item(item_data)



func _on_gold_count_changed(_amount: int, _new_count: int, _added: bool) -> void:

	if !active: 

		return

	_update_gold_count_label()



func _on_player_new_item_list_updated(item_data: ItemData) -> void:

	var row: InventoryItemRow = null

	var item_def = item_data.get_item_def()

	var current_item_data = inventory.get_item_data_with_def(item_def)

	if current_item_data == null:

		row = _add_item_row(item_data)

	else:

		row = item_row_registry[current_item_data]

	row.set_seen_state(false)
