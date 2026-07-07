class_name InventoryList extends MarginContainer



signal item_use_requested(item_data: ItemData)




@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit

@export var gold_label: Label



var item_list_rows: Dictionary[NewItemData, ItemListRow]



var is_barter: bool

var is_player_inventory: bool




func _ready() -> void:

	_clear_item_list()

	search_entry.text_changed.connect(_on_search_entry_text_changed)







func clear() -> void:

	_clear_item_list()







func load_items(items: Array[NewItemData], _is_player_inventory:= false) -> void:

	is_player_inventory = _is_player_inventory

	for item_data in items:

		_add_item_row(item_data)










func _add_item_row(item_data: NewItemData) -> void:

	var row = item_list_row_scene.instantiate()

	row.set_data(item_data)

	item_list.add_child(row)

	item_list_rows[item_data] = row

	row.left_pressed.connect(_on_row_left_pressed)

	row.right_pressed.connect(_on_row_right_pressed)

	if is_player_inventory:

		row.use_requested.connect(_on_row_use_requested)












func _clear_item_list() -> void:

	for child in item_list.get_children():

		child.queue_free()

	item_list_rows.clear()






func _sort_alphabetical(item_data_a: NewItemData, item_data_b: NewItemData) -> bool:

	return item_data_a.get_item_id() < item_data_b.get_item_id()






func _on_search_entry_text_changed(text: String) -> void:

	pass




func _on_row_left_pressed(row: ItemListRow) -> void:

	pass



func _on_row_right_pressed(row: ItemListRow) -> void:

	pass




func _on_row_use_requested(row: ItemListRow) -> void:

	item_use_requested.emit(row.item_data)