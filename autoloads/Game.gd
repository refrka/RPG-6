extends Node



enum GameState {

	MAIN_MENU,

	ACTIVE

}

var game_state: GameState

var active_save_data: SaveData

var player: PlayerNode






## Top-level Methods


func launch() -> void:

	Scenes.activate_scene(MainMenu)



func restart() -> void:

	pass







# Game start steps:

# - Fetch save_dict and load values into SaveData

#	> Fill PlayerData with saved/default values

#	> Initialize PlayerNode and load it with PlayerData

# - Load the location

#	> Initialize and activate entities, spawn player






func start(save_id: StringName) -> void:

	Events.fire(GameStartingEvent)

	var save_data = Saves.load_save_data(save_id)

	if !save_data:

		return

	if is_active():

		end()

	Scenes.activate_scene(WorldScene)

	_load_game(save_data)

	Events.fire(GameStartedEvent)




func end() -> void:

	Events.fire(GameEndingEvent)

	_unload_game()

	Events.fire(GameEndedEvent)




func save() -> void:

	Saves.save_game(active_save_data)




func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().pasued = false






func load_saved_location(location_id: StringName, new_game: bool) -> void:

	var location = Scenes.load_location(location_id)

	location._initialize()






func get_player() -> PlayerNode:

	if !player:

		player = Entities.get_player_node()

		add_child(player)

		player._initialize()

	return player





func is_active() -> bool:

	return game_state == GameState.ACTIVE











func _load_game(save_data: SaveData) -> void:

	active_save_data = save_data

	var location_id = active_save_data.last_dict["saved_location_id"]

	var new_game:= false

	if location_id == "":

		location_id = "forest_start"

		new_game = true

		pass

	load_saved_location(location_id, new_game)

	# Load location

	# Load player (data)

	# Spawn player

	# Start game


















func _unload_game() -> void:

	active_save_data = null











