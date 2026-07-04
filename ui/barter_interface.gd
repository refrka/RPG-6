class_name BarterInterface extends MarginContainer


@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")


@export var complete_transaction_button: Button

@export var player_inventory_list: InventoryList

@export var entity_inventory_list: InventoryList

@export var buy_list: VBoxContainer

@export var sell_list: VBoxContainer



var current_inventory: Inventory

var entity_barter_inventory:= BarterInventory.new()

var player_barter_inventory:= BarterInventory.new()


var sell_list_rows: Dictionary[StringName, ItemListRow]

var buy_list_rows: Dictionary[StringName, ItemListRow]




func _ready() -> void:

	complete_transaction_button.pressed.connect(_on_complete_transaction_pressed)





func load_barter_inventory(_inventory: Inventory) -> void:

	current_inventory = _inventory

	var player = Game.get_player()

	player_barter_inventory.items = player.inventory.items.duplicate(true)

	player_barter_inventory.gold = player.inventory.gold

	player_inventory_list.load_inventory(player_barter_inventory, true, true)

	if !player_inventory_list.row_left_pressed.is_connected(_on_row_left_pressed):

		player_inventory_list.row_left_pressed.connect(_on_row_left_pressed.bind(true, true))

	if !player_inventory_list.row_right_pressed.is_connected(_on_row_right_pressed):

		player_inventory_list.row_right_pressed.connect(_on_row_right_pressed.bind(true, true))

	entity_barter_inventory.items = current_inventory.items.duplicate(true)

	entity_barter_inventory.gold = current_inventory.gold

	entity_inventory_list.load_inventory(entity_barter_inventory, true, false)

	if !entity_inventory_list.row_left_pressed.is_connected(_on_row_left_pressed):

		entity_inventory_list.row_left_pressed.connect(_on_row_left_pressed.bind(true, false))

	if !entity_inventory_list.row_right_pressed.is_connected(_on_row_right_pressed):

		entity_inventory_list.row_right_pressed.connect(_on_row_right_pressed.bind(true, false))





func _add_to_sell_list(item_id: StringName) -> void:

	if sell_list_rows.has(item_id):

		var row = sell_list_rows[item_id]

		var new_count = row.count + 1

		row.set_data(item_id, new_count)

	else:

		var new_row = item_list_row_scene.instantiate()

		new_row.set_data(item_id, 1)

		new_row.right_button.visible = false

		new_row.left_button.visible = true

		new_row.left_pressed.connect(_on_row_left_pressed.bind(new_row, false, true))

		sell_list.add_child(new_row)

		sell_list_rows[item_id] = new_row



func _add_to_buy_list(item_id: StringName) -> void:

	if buy_list_rows.has(item_id):

		var row = buy_list_rows[item_id]

		var new_count = row.count + 1

		row.set_data(item_id, new_count)

	else:

		var new_row = item_list_row_scene.instantiate()

		new_row.set_data(item_id, 1)

		new_row.right_button.visible = true

		new_row.left_button.visible = false

		new_row.right_pressed.connect(_on_row_right_pressed.bind(new_row, false, false))

		buy_list.add_child(new_row)

		buy_list_rows[item_id] = new_row




func _remove_from_sell_list(item_id: StringName) -> void:

	if sell_list_rows.has(item_id):

		var row = sell_list_rows[item_id]

		var new_count = row.count - 1

		if new_count == 0:

			row.queue_free()

			sell_list_rows.erase(item_id)

		row.set_data(item_id, new_count)




func _remove_from_buy_list(item_id: StringName) -> void:

	if buy_list_rows.has(item_id):

		var row = buy_list_rows[item_id]

		var new_count = row.count - 1

		if new_count == 0:

			row.queue_free()

			buy_list_rows.erase(item_id)

		row.set_data(item_id, new_count)






func _complete_transaction() -> void:

	var player = Game.get_player()

	var total_buy_value = _get_total_buy_value()

	var total_sell_value = _get_total_sell_value()

	for row in buy_list_rows.values():

		player.inventory.add_item(row.item_id, row.count)

		player_barter_inventory.add_item(row.item_id, row.count)

		current_inventory.remove_item(row.item_id, row.count)

	for row in sell_list_rows.values():

		player.inventory.remove_item(row.item_id, row.count)

		current_inventory.add_item(row.item_id, row.count)

		entity_barter_inventory.add_item(row.item_id, row.count)

	player_barter_inventory.add_gold(total_sell_value)

	player.inventory.add_gold(total_sell_value)

	entity_barter_inventory.remove_gold(total_sell_value)

	current_inventory.remove_gold(total_sell_value)

	player_barter_inventory.remove_gold(total_buy_value)

	player.inventory.remove_gold(total_buy_value)

	entity_barter_inventory.add_gold(total_buy_value)

	current_inventory.add_gold(total_buy_value)

	_clear_buy_list()

	_clear_sell_list()





func _can_complete_transaction() -> bool:

	var player = Game.get_player()

	if buy_list_rows.is_empty() and sell_list_rows.is_empty():

		return false

	if player.inventory.gold < _get_total_buy_value():

		return false

	if current_inventory.gold < _get_total_sell_value():

		return false

	return true





func _clear_buy_list() -> void:

	for child in buy_list.get_children():

		child.queue_free()

	buy_list_rows.clear()



func _clear_sell_list() -> void:

	for child in sell_list.get_children():

		child.queue_free()

	sell_list_rows.clear()








func _get_total_buy_value() -> int:

	var total_value = 0
	
	for row in buy_list_rows.values():

		var item_def = Items.get_def(row.item_id)

		total_value += (item_def.gold_value * row.count)

	print("buy (no factor):", total_value)

	total_value = int(ceil(total_value * entity_barter_inventory.buy_factor))

	print("buy:", total_value)

	return total_value



func _get_total_sell_value() -> int:

	var total_value = 0
	
	for row in sell_list_rows.values():

		var item_def = Items.get_def(row.item_id)

		total_value += (item_def.gold_value * row.count)

	print("sell (no factor):", total_value)

	total_value = int(ceil(total_value * entity_barter_inventory.sell_factor))

	print("sell:", total_value)

	return total_value










func _on_row_left_pressed(row: ItemListRow, is_inventory_row: bool, is_player_inventory: bool) -> void:

	if is_inventory_row:

		if !is_player_inventory:

			_add_to_buy_list(row.item_id)

			entity_barter_inventory.remove_item(row.item_id, 1)

	else:

		if is_player_inventory:

			_remove_from_sell_list(row.item_id)

			player_barter_inventory.add_item(row.item_id, 1)







func _on_row_right_pressed(row: ItemListRow, is_inventory_row: bool, is_player_inventory: bool) -> void:

	if is_inventory_row:

		if is_player_inventory:

			_add_to_sell_list(row.item_id)

			player_barter_inventory.remove_item(row.item_id, 1)

	else:

		if !is_player_inventory:

			_remove_from_buy_list(row.item_id)

			entity_barter_inventory.add_item(row.item_id, 1)







func _on_complete_transaction_pressed() -> void:

	if _can_complete_transaction():

		_complete_transaction()