class_name InventoryList extends MarginContainer


signal row_right_pressed(row: ItemListRow)

signal row_left_pressed(row: ItemListRow)



@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit





var inventory: Inventory

var item_list_registry: Dictionary[StringName, ItemListRow]

var is_player_inventory: bool




func _ready() -> void:

	search_entry.text_changed.connect(_on_search_entry_text_changed)






func load_inventory(_inventory: Inventory, barter:= false, _is_player_inventory:= false) -> void:

	is_player_inventory = _is_player_inventory
	
	if inventory == _inventory:

		return

	inventory = _inventory

	_clear_item_list()

	var items = inventory.items.keys().duplicate()

	items.sort_custom(_sort_alphabetical)

	for item_id in items:

		var count = inventory.items[item_id]

		_add_item_row(item_id, count, barter, is_player_inventory)

	inventory.inventory_updated.connect(_on_inventory_updated)




func _add_item_row(item_id: StringName, count: int, barter: bool, is_player_inventory: bool) -> void:

	var row = item_list_row_scene.instantiate()

	row.set_data(item_id, count)

	row.left_pressed.connect(row_left_pressed.emit.bind(row))

	row.right_pressed.connect(row_right_pressed.emit.bind(row))

	item_list.add_child(row)

	item_list_registry[item_id] = row

	if barter:

		row.right_button.visible = is_player_inventory

		row.left_button.visible = not is_player_inventory

	else:

		row.right_button.visible = false

		row.left_button.visible = false





func _clear_item_list() -> void:

	for child in item_list.get_children():

		child.queue_free()



func _show_all_rows() -> void:

	for row in item_list_registry.values():

		row.visible = true




func _sort_alphabetical(string_a: StringName, string_b: StringName) -> bool:

	return string_a < string_b






func _on_search_entry_text_changed(text: String) -> void:

	if text == "":

		_show_all_rows()

		return

	for item_id in item_list_registry:

		text = text.lstrip(" \"'\\/[]{}!@#$%^&*()").rstrip(" \"'\\/[]{}!@#$%^&*()")

		var row = item_list_registry[item_id]

		if item_id.contains(text):

			row.visible = true

		else:

			row.visible = false





func _on_inventory_updated(item_id: StringName, _change: int, count: int) -> void:

	if item_list_registry.has(item_id):

		var row = item_list_registry[item_id]

		if count == 0:

			item_list_registry.erase(item_id)
				
			row.queue_free()

		else:

			row.set_data(item_id, count)

	else:

		var barter = inventory is BarterInventory

		_add_item_row(item_id, count, barter, is_player_inventory)

