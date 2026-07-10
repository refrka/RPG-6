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

	search_entry.text_changed.connect(_on_search_text_changed)

	search_entry.editing_toggled.connect(_on_search_editing_toggled)







func clear() -> void:

	current_inventory = null

	_clear_item_list()







func load_inventory(inventory: Inventory, _is_player_inventory:= false) -> void:

	current_inventory = inventory

	gold_label.text = "%s g" % inventory.get_gold_count()

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




func _show_all_rows() -> void:

	for row in item_list_rows.values():

		row.visible = true





func _sort_alphabetical(item_data_a: ItemData, item_data_b: ItemData) -> bool:

	return item_data_a.get_item_id() < item_data_b.get_item_id()






func _on_search_text_changed(text: String) -> void:

	if text == "":

		_show_all_rows()

		return

	for item_data in item_list_rows:

		var row = item_list_rows[item_data]

		if item_data.get_def().display_name.to_lower().contains(text.to_lower()):

			row.visible = true

		else:

			row.visible = false




func _on_search_editing_toggled(state: bool) -> void:

	if state == false:

		search_entry.release_focus()




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