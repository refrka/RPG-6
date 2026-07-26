class_name InventoryDisplay extends MarginContainer


@onready var inventory_item_row_scene:= preload("res://ui/inventory_item_row.tscn")

@onready var equipment_item_row_scene:= preload("res://ui/equipment_item_row.tscn")



@export var item_list: VBoxContainer

@export var filter_entry: LineEdit



var inventory: Inventory

var item_row_registry: Dictionary[ItemData, InventoryItemRow]

var selected_row: InventoryItemRow






func _ready() -> void:

	filter_entry.text_changed.connect(_on_filter_text_changed)





func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	_load_item_list()





func clear() -> void:

	_clear_item_list()

	inventory = null

	item_row_registry.clear()

	selected_row = null





func _load_item_list() -> void:

	_clear_item_list()

	var items = inventory.item_list.duplicate()

	var row: InventoryItemRow = null

	for item_data in items:

		match item_data.get_script():

			EquipmentData:

				row = equipment_item_row_scene.instantiate() as EquipmentItemRow

			_:

				row = inventory_item_row_scene.instantiate() as InventoryItemRow

		row.load_item_data(item_data)

		row.row_selected.connect(_on_row_selected)

		row.discard_requested.connect(_on_discard_requested)

		item_row_registry[item_data] = row

		item_list.add_child(row)





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

		for item_data in item_row_registry:

			var row = item_row_registry[item_data]

			if item_data.get_display_name().contains(item_name):

				row.show()

			else:

				row.hide()







func _clear_item_list() -> void:

	for row in item_list.get_children():

		row.queue_free()




func _on_row_selected(row: InventoryItemRow) -> void:

	_select_row(row)



func _on_discard_requested(row: InventoryItemRow) -> void:

	var count_selector = UI.show_count_selector(0, row.item_data.get_count(), false)

	count_selector.count_submitted.connect(_on_discard_count_submitted.bind(row.item_data))




func _on_discard_count_submitted(count: int, item_data: ItemData) -> void:

	item_data.remove_amount(count)



func _on_filter_text_changed(text: String) -> void:

	_filter_item_name(text)