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




func _deactivate() -> void:

	super()

	if target_entity:

		_close()




func _on_close_pressed() -> void:

	_close()



func _on_sell_requested(item_data: ItemData) -> void:

	var count_selector = UI.show_count_selector(0, item_data.get_count(), "Selling %s" % item_data.get_display_name())

	count_selector.count_submitted.connect(_on_sell_count_submitted.bind(item_data), CONNECT_ONE_SHOT)



func _on_buy_requested(item_data: ItemData) -> void:

	var count_selector = UI.show_count_selector(0, item_data.get_count(), "Buying %s" % item_data.get_display_name())

	count_selector.count_submitted.connect(_on_buy_count_submitted.bind(item_data), CONNECT_ONE_SHOT)



func _on_sell_count_submitted(count: int, item_data: ItemData) -> void:

	pass



func _on_buy_count_submitted(count: int, item_data: ItemData) -> void:

	pass