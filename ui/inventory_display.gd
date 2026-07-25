class_name InventoryDisplay extends MarginContainer


@onready var inventory_item_row_scene:= preload("res://ui/inventory_item_row.tscn")

@onready var equipment_item_row_scene:= preload("res://ui/equipment_item_row.tscn")



@export var item_list: VBoxContainer



var inventory: Inventory

var item_row_registry: Dictionary[ItemData, InventoryItemRow]

var selected_row: InventoryItemRow





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






func _clear_item_list() -> void:

	for row in item_list.get_children():

		row.queue_free()




func _on_row_selected(row: InventoryItemRow) -> void:

	_select_row(row)