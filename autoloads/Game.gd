extends Node



enum GameState {

	MAIN_MENU,

	ACTIVE

}

var game_state: GameState

var active_save_data: SaveData

var player: PlayerNode





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS






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

	var save_data = Saves.load_save_data(save_id)

	if !save_data:

		return

	if is_active():

		end()

	Events.fire(GameStartingEvent)

	game_state = GameState.ACTIVE

	Scenes.activate_scene(WorldScene)

	_load_game(save_data)

	Events.fire(GameStartedEvent)




func end() -> void:

	Events.fire(GameEndingEvent)

	_unload_game()

	UI.deactivate_overlays()

	Scenes.activate_scene(MainMenu)

	game_state = GameState.MAIN_MENU

	Events.fire(GameEndedEvent)

	player.reset()




func save() -> void:

	Saves.save_game(active_save_data)

	Events.fire(GameSavedEvent)




func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().paused = false






func load_saved_location(location_id: StringName) -> void:

	var location = Scenes.load_location(location_id)




func hold_player_node() -> void:

	player.reparent(self)

	player._deactivate()

	player.hide()




func get_player() -> PlayerNode:

	if !player:

		player = Entities.get_player_node()

		add_child(player)

		player._initialize()

	return player




func get_save_data() -> SaveData:

	return active_save_data





func get_timer(duration: float) -> SceneTreeTimer:

	var timer = get_tree().create_timer(duration)

	return timer





func is_active() -> bool:

	return game_state == GameState.ACTIVE



func is_paused() -> bool:

	return get_tree().paused







func _load_game(save_data: SaveData) -> void:

	active_save_data = save_data

	active_save_data.load_dictionary()

	var location_id = active_save_data.last_dict["saved_location_id"]

	var spawn_id = active_save_data.last_dict["saved_spawn_id"]

	if location_id == "":

		location_id = "forest_start"

		spawn_id = "start"

		pass

	player = get_player()

	player._load_dictionary(active_save_data.last_dict["player"])

	var world_scene = Scenes.get_world_scene()
	
	var location = world_scene.activate_location(location_id)

	location.spawn_entity_node(player, spawn_id)

	# Load location

	# Load player (data)

	# Spawn player

	# Start game










func _unload_game() -> void:

	active_save_data = null

	hold_player_node()

	var world_scene = Scenes.get_world_scene()

	world_scene.unload_location()











func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		if is_active():

			save()