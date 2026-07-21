class_name DebugShitPanel extends Overlay




@export var button_1: Button






func _ready() -> void:

	button_1.pressed.connect(_on_button_1_pressed)

	Debug.debug_shit_panel = self









func _on_button_1_pressed() -> void:

	Events.subscribe(GameStartingEvent, _on_game_starting_event)

	Events.subscribe(PlayerAddedItemsEvent, _on_player_added_items_event)

	Events.subscribe(GameEndingEvent, _on_game_ending_event)

	Game.start("test")

	Events.fire(PlayerAddedItemsEvent)

	Game.end()

	Events.fire(PlayerAddedItemsEvent)








func _on_game_starting_event(event: Event) -> void:

	print("GameStartingEvent heard")



func _on_player_added_items_event(event: Event) -> void:

	print("PlayerAddedItemsEvent heard")



func _on_game_ending_event(event: Event) -> void:

	print("GameEndingEvent heard")