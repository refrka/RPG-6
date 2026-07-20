class_name InventoryList extends MarginContainer




signal equip_requested(item_data: ItemData)

signal unequip_requested(item_data: ItemData)

signal buy_requested(item_data: ItemData, amount: int)

signal sell_requested(item_data: ItemData, amount: int)

signal discard_requested(item_data: ItemData, amount: int)





@onready var item_row_scene:= preload("res://ui/inventory_item_row.tscn")


@export var item_list: VBoxContainer

var inventory: Inventory

var item_row_registry: Dictionary[ItemData, InventoryItemRow]



func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	inventory.item_count_changed.connect(_on_item_count_changed)

	_update_item_list()




func _update_item_list() -> void:

	_clear_item_list()

	if !inventory:

		return

	for item_data in inventory.item_list:

		_add_item_row(item_data)




func _add_item_row(item_data: ItemData) -> void:

	var row = item_row_scene.instantiate() as InventoryItemRow

	row.equip_requested.connect(_on_equip_requested)

	row.unequip_requested.connect(_on_unequip_requested)

	row.buy_requested.connect(_on_buy_requested)

	row.sell_requested.connect(_on_sell_requested)

	row.discard_requested.connect(_on_discard_requested)

	row.set_row_data(item_data)

	item_data.data_emptied.connect(_on_item_data_emptied.bind(row))

	item_list.add_child(row)

	item_row_registry[item_data] = row




func _clear_item_list() -> void:

	for child in item_list.get_children():

		child.queue_free()





func _on_equip_requested(row: InventoryItemRow) -> void:

	pass



func _on_unequip_requested(row: InventoryItemRow) -> void:

	pass



func _on_buy_requested(row: InventoryItemRow) -> void:

	pass



func _on_sell_requested(row: InventoryItemRow) -> void:

	pass



func _on_discard_requested(row: InventoryItemRow) -> void:

	var count_selector = UI.show_count_selector(0, row.item_data.get_count())

	count_selector.count_submitted.connect(_on_discard_count_submitted.bind(row.item_data))



func _on_discard_count_submitted(amount: int, item_data: ItemData) -> void:

	discard_requested.emit(item_data, amount)




func _on_item_data_emptied(item_data: ItemData, row: InventoryItemRow) -> void:

	row.queue_free()

	item_row_registry.erase(item_data)



func _on_item_count_changed(item_data: ItemData, _amount: int, _removed: bool) -> void:

	if !item_row_registry.has(item_data):

		_add_item_row(item_data)