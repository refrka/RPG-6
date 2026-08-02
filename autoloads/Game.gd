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

	if is_paused():

		resume()

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




func transition_to(location_id: StringName, spawn_id: StringName) -> void:

	hold_player_node()

	var world_scene = Scenes.get_world_scene()

	world_scene.active_location.remove_entity_node(player)

	var location = Scenes.load_location(location_id)

	location.spawn_entity_node(player, spawn_id)

	Events.fire(PlayerEnteredLocationEvent, {"location": location})







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



func get_camera() -> GameCamera:

	return get_tree().get_first_node_in_group("game_camera")



func get_game_root() -> Node:

	return get_tree().get_first_node_in_group("game_root")



func get_mouse_position() -> Vector2:

	return Scenes.get_world_scene().get_global_mouse_position()



func get_mouse_direction(from_entity: EntityNode = null) -> Vector2:

	if !from_entity:

		from_entity = Game.get_player()

	return from_entity.global_position.direction_to(get_mouse_position())




func is_active() -> bool:

	return game_state == GameState.ACTIVE



func is_paused() -> bool:

	return get_tree().paused







func _load_game(save_data: SaveData) -> void:

	active_save_data = save_data

	player = get_player()

	var location_id:= &""

	var spawn_id:= &""

	var first_load:= false

	if active_save_data.last_dict["player"].is_empty():

		location_id = &"forest_start"

		spawn_id = &"start"

		first_load = true

	else:

		Globals.load_dictionary(active_save_data.last_dict["globals"])

		player._load_dictionary(active_save_data.last_dict["player"])

		location_id = active_save_data.last_dict["player"]["location_id"]

		spawn_id = active_save_data.last_dict["player"]["spawn_id"]

	active_save_data.load_dictionary()
	
	var location = Scenes.load_location(location_id)

	location.spawn_entity_node(player, spawn_id)

	player.active_spawn_id = spawn_id

	player.active_location = location

	if first_load:

		Events.fire(PlayerEnteredLocationEvent, {"location": location})

	# Load location

	# Load player (data)

	# Spawn player

	# Start game










func _unload_game() -> void:

	active_save_data = null

	hold_player_node()











func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		if is_active():

			save()