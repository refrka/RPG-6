class_name InventoryList extends MarginContainer


@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit





var inventory: Inventory

var item_list_registry: Dictionary[StringName, ItemListRow]






func _ready() -> void:

	search_entry.text_changed.connect(_on_search_entry_text_changed)






func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	_clear_item_list()

	var items = inventory.items.keys().duplicate()

	items.sort_custom(_sort_alphabetical)

	for item_id in items:

		var row = item_list_row_scene.instantiate()

		var count = inventory.items[item_id]

		row.set_data(item_id, count)

		item_list.add_child(row)

		item_list_registry[item_id] = row

	inventory.inventory_updated.connect(_on_inventory_updated)







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





func _on_inventory_updated(item_id: StringName, count: int) -> void:

	var row = item_list_registry[item_id]

	row.set_data(item_id, count)