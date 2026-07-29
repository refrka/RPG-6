class_name BarterPanel extends Overlay




@export var barter_title_label: Label

@export var dialogue_text_label: Label

@export var close_button: Button

@export var player_inventory_display: InventoryDisplay

@export var entity_inventory_display: InventoryDisplay


var target_entity: EntityNode



func _ready() -> void:

	close_button.pressed.connect(_on_close_pressed)

	player_inventory_display.sell_requested.connect(_on_sell_requested)

	entity_inventory_display.buy_requested.connect(_on_buy_requested)





func load_barter_inventories(_target_entity: EntityNode) -> void:

	target_entity = _target_entity

	barter_title_label.text = "Bartering with %s" % target_entity.get_display_name()

	entity_inventory_display.load_inventory(target_entity.inventory)

	var player = Game.get_player()

	player_inventory_display.load_inventory(player.inventory)






func clear() -> void:

	target_entity = null

	player_inventory_display.clear()

	entity_inventory_display.clear()





func set_dialogue_text(dialogue_text: DialogueText) -> void:

	dialogue_text_label.text = dialogue_text.get_line(0)









func _close() -> void:

	clear()

	close_requested.emit()




func _activate() -> void:

	super()

	player_inventory_display.active = true

	entity_inventory_display.active = true

	player_inventory_display.wake()

	entity_inventory_display.wake()




func _deactivate() -> void:

	super()

	player_inventory_display.active = false

	entity_inventory_display.active = false

	player_inventory_display.sleep()

	entity_inventory_display.sleep()

	if target_entity:

		_close()



func _on_close_pressed() -> void:

	_close()



func _on_sell_requested(item_data: ItemData) -> void:

	var max_count = min(item_data.get_count(), Items.get_max_value_count(target_entity.inventory.get_gold_count(), item_data.get_item_def()))

	var count_selector = UI.show_count_selector(0, max_count, "Selling %s" % item_data.get_display_name(), false, true)

	count_selector.item_def = item_data.get_item_def()

	count_selector.count_submitted.connect(_on_sell_count_submitted.bind(item_data), CONNECT_ONE_SHOT)



func _on_buy_requested(item_data: ItemData) -> void:

	var player = Game.get_player()

	var max_count = min(item_data.get_count(), Items.get_max_value_count(player.inventory.get_gold_count(), item_data.get_item_def()))

	var count_selector = UI.show_count_selector(0, max_count, "Buying %s" % item_data.get_display_name(), false, true)

	count_selector.item_def = item_data.get_item_def()

	count_selector.count_submitted.connect(_on_buy_count_submitted.bind(item_data), CONNECT_ONE_SHOT)







func _on_sell_count_submitted(count: int, item_data: ItemData) -> void:

	var total_value = item_data.get_total_value(count)

	var player = Game.get_player()

	player.inventory.transfer_item_data_to(item_data, target_entity.inventory, count)

	target_entity.inventory.transfer_gold_to(total_value, player.inventory)

	Events.fire(ItemsSoldEvent, {"item_def": item_data.get_item_def(), "amount": count, "value": total_value})




func _on_buy_count_submitted(count: int, item_data: ItemData) -> void:

	var total_value = item_data.get_total_value(count)

	var player = Game.get_player()

	target_entity.inventory.transfer_item_data_to(item_data, player.inventory, count)

	player.inventory.transfer_gold_to(total_value, target_entity.inventory)

	Events.fire(ItemsBoughtEvent, {"item_def": item_data.get_item_def(), "amount": count, "value": total_value})