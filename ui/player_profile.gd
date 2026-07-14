class_name PlayerProfile extends UIOverlay




@export var inventory_panel: PlayerInventoryPanel

@export var info_panel: PlayerInfoPanel





func _ready() -> void:

	super()

	Game.game_started.connect(_on_game_started)

	Game.game_ended.connect(_on_game_ended)

	inventory_panel.item_use_requested.connect(_on_item_use_requested)








func _on_profile_pressed() -> void:

	toggle()





func _on_game_started() -> void:

	var player = Game.get_player()

	info_panel.load_info(player)

	inventory_panel.load_inventory(player.inventory, true)





func _on_game_ended() -> void:

	inventory_panel.clear_inventory()





func _on_item_use_requested(item_data: ItemData) -> void:

	var player = Game.get_player()

	player.use_item(item_data)





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile"):

		if Game.is_active():

			if active:

				toggle()

			elif UI.overlay_list.is_empty():

				toggle()