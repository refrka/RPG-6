class_name BarterInterface extends MarginContainer



@export var sell_list_row_scene:= preload("res://ui/barter_sell_list_row.tscn")

@export var buy_list_row_scene:= preload("res://ui/barter_buy_list_row.tscn")



@export var complete_transaction_button: Button

@export var player_item_list: VBoxContainer

@export var player_gold_label: Label

@export var entity_item_list: VBoxContainer

@export var entity_gold_label: Label



var source_inventory: Inventory



func clear_interface() -> void:

	_clear_player_item_list()

	_clear_entity_item_list()

	if source_inventory and source_inventory.gold_updated.is_connected(_on_entity_gold_updated):

		source_inventory.gold_updated.disconnect(_on_entity_gold_updated)

	if source_inventory and source_inventory.item_data_count_updated.is_connected(_on_entity_item_data_count_updated):

		source_inventory.item_data_count_updated.disconnect(_on_entity_item_data_count_updated)






func load_inventory(_source_inventory: Inventory) -> void:

	clear_interface()

	source_inventory = _source_inventory

	entity_gold_label.text = "%s g" % source_inventory.get_gold_count()

	source_inventory.gold_updated.connect(_on_entity_gold_updated)

	_load_player_inventory()

	for item_data in source_inventory.get_items():

		var row = buy_list_row_scene.instantiate()

		row.set_data(item_data)

		row.buy_requested.connect(_on_buy_requested)

		entity_item_list.add_child(row)











func _load_player_inventory() -> void:

	_clear_player_item_list()

	var player = Game.get_player()

	if !player.inventory.gold_updated.is_connected(_on_player_gold_updated):

		player.inventory.gold_updated.connect(_on_player_gold_updated)

	if !player.inventory.item_data_count_updated.is_connected(_on_player_item_data_count_updated):

		player.inventory.item_data_count_updated.connect(_on_player_item_data_count_updated)

	var items = player.inventory.get_items()

	items.sort_custom(_sort_alphabetical)

	for item_data in items:

		var row = sell_list_row_scene.instantiate()

		row.set_data(item_data)

		row.sell_requested.connect(_on_sell_requested)

		player_item_list.add_child(row)






func _add_item_row(item_data: ItemData, list: VBoxContainer) -> PanelContainer:

	var row: Control

	if list == entity_item_list:

		row = buy_list_row_scene.instantiate()

		row.buy_requested.connect(_on_buy_requested)

	elif list == player_item_list:

		row = sell_list_row_scene.instantiate()

		row.sell_requested.connect(_on_sell_requested)

	row.set_data(item_data)

	list.add_child(row)

	_sort_rows()

	return row






func _can_buy(item_data: ItemData, count: int) -> bool:

	var total_value = Items.get_value_of_items({item_data: count})

	var player = Game.get_player()

	if player.inventory.get_gold_count() < total_value:

		return false

	return true




func _can_sell(item_data: ItemData, count: int) -> bool:

	var total_value = Items.get_value_of_items({item_data: count})

	if source_inventory.get_gold_count() < total_value:

		return false

	return true




func _buy(item_data: ItemData, count: int) -> void:

	var total_value = Items.get_value_of_items({item_data: count})

	var player = Game.get_player()

	player.inventory.remove_gold(total_value)

	source_inventory.add_gold(total_value)

	source_inventory.transfer_to_inventory(item_data, player.inventory, count)




func _sell(item_data: ItemData, count: int) -> void:

	var total_value = Items.get_value_of_items({item_data: count})

	var player = Game.get_player()

	source_inventory.remove_gold(total_value)

	player.inventory.add_gold(total_value)

	player.inventory.transfer_to_inventory(item_data, source_inventory, count)





func _sort_rows() -> void:

	var item_list = entity_item_list.get_children().duplicate()

	item_list.sort_custom(_sort_row_alphabetical)

	for i in range(item_list.size()):

		var row = item_list[i]

		row.get_parent().move_child(row, i)





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






func _get_row_with_data(item_data: ItemData, list_container: VBoxContainer) -> PanelContainer:

	for row in list_container.get_children():

		if row.item_data == item_data:

			return row

	return null







func _sort_alphabetical(item_data_a: ItemData, item_data_b: ItemData) -> bool:

	return item_data_a.get_def().display_name < item_data_b.get_def().display_name





func _sort_row_alphabetical(row_a: PanelContainer, row_b: PanelContainer) -> bool:

	return row_a.item_data.get_def().display_name < row_b.item_data.get_def().display_name









func _on_buy_requested(item_data: ItemData, count: int) -> void:

	if _can_buy(item_data, count):

		_buy(item_data, count)






func _on_sell_requested(item_data: ItemData, count: int) -> void:

	if _can_sell(item_data, count):

		_sell(item_data, count)





func _on_player_gold_updated(_amount: int, new_total: int, _removed: bool) -> void:

	player_gold_label.text = "%s g" % new_total



func _on_entity_gold_updated(_amount: int, new_total: int, _removed: bool) -> void:

	entity_gold_label.text = "%s g" % new_total




func _on_entity_item_data_count_updated(_amount: int, item_data: ItemData, _removed: bool) -> void:

	var row = _get_row_with_data(item_data, entity_item_list)
	
	if !row:

		_add_item_row(item_data, entity_item_list)



func _on_player_item_data_count_updated(_amount: int, item_data: ItemData, _removed: bool) -> void:

	var row = _get_row_with_data(item_data, player_item_list)
	
	if !row:

		_add_item_row(item_data, player_item_list)

