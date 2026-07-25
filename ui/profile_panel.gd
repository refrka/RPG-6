class_name ProfilePanel extends Overlay



@export var inventory_display: InventoryDisplay


func _ready() -> void:

	Events.subscribe(GameStartedEvent, _on_game_started)

	Events.subscribe(GameEndedEvent, _on_game_ended)





func load_player() -> void:

	var player = Game.get_player()

	inventory_display.load_inventory(player.inventory)




func unload_player() -> void:

	inventory_display.clear()




func _on_game_started(_event: Event) -> void:

	load_player()



func _on_game_ended(_event: Event) -> void:

	unload_player()