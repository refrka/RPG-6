class_name NewInventoryList extends MarginContainer





@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")



@export var item_list: VBoxContainer

@export var search_entry: LineEdit

@export var gold_label: Label



var inventory: NewInventory









func load_inventory(_inventory: NewInventory) -> void:

	inventory = _inventory

	