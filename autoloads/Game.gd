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






func load_saved_location(location_id: StringName) -> void:

	var location = Scenes.load_location(location_id)






func get_player() -> PlayerNode:

	if !player:

		player = Entities.get_player_node()

		add_child(player)

		player._initialize()

	return player





func get_timer(duration: float) -> SceneTreeTimer:

	var timer = get_tree().create_timer(duration)

	return timer





func is_active() -> bool:

	return game_state == GameState.ACTIVE











func _load_game(save_data: SaveData) -> void:

	active_save_data = save_data

	var location_id = active_save_data.last_dict["saved_location_id"]

	if location_id == "":

		location_id = "forest_start"

		@warning_ignore("confusable_local_declaration")

		var cutscene = Scenes.run_cutscene(NewGameCutscene)

		await cutscene.cutscene_ended

		pass

	var world_scene = Scenes.get_world_scene()
	
	world_scene.activate_location(location_id)

	await get_timer(3.0).timeout

	var cutscene = Scenes.run_cutscene(NewGameCutscene)

	await cutscene.cutscene_ended

	await get_timer(3.0).timeout

	cutscene = Scenes.run_cutscene(NewGameCutscene)

	# Load location

	# Load player (data)

	# Spawn player

	# Start game


















func _unload_game() -> void:

	active_save_data = null











