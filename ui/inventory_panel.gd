class_name InventoryPanel extends MarginContainer









@export var inventory_list: InventoryList







func _ready() -> void:

	Game.game_started.connect(_on_game_started)

	Game.game_ended.connect(_on_game_ended)




func _on_game_started() -> void:

	var player = Game.get_player()

	inventory_list.load_items(player.inventory.get_items())



func _on_game_ended() -> void:

	inventory_list.clear()