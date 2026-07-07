class_name BarterInterface extends MarginContainer


@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")


@export var complete_transaction_button: Button

@export var player_inventory_list: InventoryList

@export var entity_inventory_list: InventoryList

@export var buy_list: VBoxContainer

@export var sell_list: VBoxContainer












func _clear_buy_list() -> void:

	for child in buy_list.get_children():

		child.queue_free()





func _clear_sell_list() -> void:

	for child in sell_list.get_children():

		child.queue_free()








