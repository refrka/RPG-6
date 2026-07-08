class_name InventoryList extends MarginContainer



signal item_use_requested(item_data: ItemData)




@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit

@export var gold_label: Label



var item_list_rows: Dictionary[ItemData, ItemListRow]


var current_inventory: Inventory

var is_barter: bool

var is_player_inventory: bool




func _ready() -> void:

	_clear_item_list()

	search_entry.text_changed.connect(_on_search_entry_text_changed)







func clear() -> void:

	_clear_item_list()







func load_inventory(inventory: Inventory, _is_player_inventory:= false) -> void:

	current_inventory = inventory

	current_inventory.item_data_count_updated.connect(_on_inventory_count_updated)

	is_player_inventory = _is_player_inventory

	var items = current_inventory.get_items()

	items.sort_custom(_sort_alphabetical)

	for item_data in items:

		_add_item_row(item_data)










func _add_item_row(item_data: ItemData) -> ItemListRow:

	var row = item_list_row_scene.instantiate()

	row.set_data(item_data)

	item_list.add_child(row)

	item_list_rows[item_data] = row

	row.left_pressed.connect(_on_row_left_pressed)

	row.right_pressed.connect(_on_row_right_pressed)

	if is_player_inventory:

		row.use_requested.connect(_on_row_use_requested)

	return row






func _get_current_row_item_data_list() -> Array[ItemData]:

	var current_row_item_data: Array[ItemData] = []

	for row in item_list.get_children():

		current_row_item_data.append(row.item_data)

	return current_row_item_data





func _clear_item_list() -> void:

	for child in item_list.get_children():

		child.queue_free()

	item_list_rows.clear()






func _sort_alphabetical(item_data_a: ItemData, item_data_b: ItemData) -> bool:

	return item_data_a.get_item_id() < item_data_b.get_item_id()






func _on_search_entry_text_changed(text: String) -> void:

	pass




func _on_row_left_pressed(row: ItemListRow) -> void:

	pass



func _on_row_right_pressed(row: ItemListRow) -> void:

	pass




func _on_row_use_requested(row: ItemListRow) -> void:

	item_use_requested.emit(row.item_data)




func _on_inventory_count_updated(_amount: int, item_data: ItemData, _removed: bool) -> void:

	if !item_list_rows.has(item_data):

		var current_row_item_data = _get_current_row_item_data_list()

		current_row_item_data.append(item_data)

		current_row_item_data.sort_custom(_sort_alphabetical)

		var index = current_row_item_data.find(item_data)

		var new_row = _add_item_row(item_data)

		item_list.move_child(new_row, index)

	else:

		var row = item_list_rows[item_data]

		row.set_data(item_data)