class_name BarterInterface extends MarginContainer



@export var sell_list_row_scene:= preload("res://ui/barter_sell_list_row.tscn")

@export var buy_list_row_scene:= preload("res://ui/barter_buy_list_row.tscn")



@export var complete_transaction_button: Button

@export var player_item_list: VBoxContainer

@export var player_gold_label: Label

@export var entity_item_list: VBoxContainer

@export var entity_gold_label: Label





func clear_interface() -> void:

	_clear_player_item_list()

	_clear_entity_item_list()






func load_inventory(source_inventory: Inventory) -> void:

	clear_interface()

	_load_player_inventory()

	for item_data in source_inventory.get_items():

		var row = buy_list_row_scene.instantiate()

		row.set_data(item_data)

		entity_item_list.add_child(row)











func _load_player_inventory() -> void:

	_clear_player_item_list()

	var player = Game.get_player()

	var items = player.inventory.get_items()

	items.sort_custom(_sort_alphabetical)

	for item_data in items:

		var row = sell_list_row_scene.instantiate()

		row.set_data(item_data)

		player_item_list.add_child(row)





func _update_player_gold() -> void:

	var player = Game.get_player()

	player_gold_label.text = "%s g" % player.inventory.get_gold_count()





func _update_entity_gold() -> void:

	pass





func _clear_player_item_list() -> void:

	for child in player_item_list.get_children():

		child.queue_free()




func _clear_entity_item_list() -> void:

	for child in entity_item_list.get_children():

		child.queue_free()





func _sort_alphabetical(item_data_a: ItemData, item_data_b: ItemData) -> bool:

	return item_data_a.get_def().display_name < item_data_b.get_def().display_name