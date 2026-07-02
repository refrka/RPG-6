class_name InventoryList extends MarginContainer


@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit





var inventory: Inventory

var item_list_registry: Dictionary[StringName, ItemListRow]




func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	_clear_item_list()

	for item_id in inventory.items:

		var row = item_list_row_scene.instantiate()

		var count = inventory.items[item_id]

		row.set_data(item_id, count)

		item_list.add_child(row)

		item_list_registry[item_id] = row









func _clear_item_list() -> void:

	for child in item_list.get_children():

		child.queue_free()
