class_name BarterInterface extends MarginContainer


@onready var item_list_row_scene:= preload("res://ui/item_list_row.tscn")




@export var player_inventory_list: InventoryList

@export var entity_inventory_list: InventoryList

@export var buy_list: VBoxContainer

@export var sell_list: VBoxContainer


var entity_barter_inventory: Inventory

var player_barter_inventory: Inventory


var sell_list_rows: Dictionary[StringName, ItemListRow]

var buy_list_rows: Dictionary[StringName, ItemListRow]



func load_barter_inventory(_inventory: Inventory) -> void:

	var player = Game.get_player()

	player_barter_inventory = player.inventory.duplicate()

	player_inventory_list.load_inventory(player_barter_inventory, true, true)

	if !player_inventory_list.row_left_pressed.is_connected(_on_row_left_pressed):

		player_inventory_list.row_left_pressed.connect(_on_row_left_pressed.bind(true, true))

	if !player_inventory_list.row_right_pressed.is_connected(_on_row_right_pressed):

		player_inventory_list.row_right_pressed.connect(_on_row_right_pressed.bind(true, true))

	entity_barter_inventory = _inventory.duplicate()

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