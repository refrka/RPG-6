extends Node






var active_save_data: SaveData

var player: PlayerNode





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func launch() -> void:

	Scenes.activate_scene(MainMenu)

	Events.fire(GameLaunchedEvent)





func restart() -> void:

	pass






func start(save_id: StringName) -> void:

	if active_save_data:

		end()

	active_save_data = Saves.load_save_data(save_id)

	var world_scene = Scenes.activate_scene(WorldScene)

	world_scene.enter_location(active_save_data.get_last_location_id(), active_save_data.get_last_spawn_id())

	player._initialize(active_save_data.player_data)

	player._activate()





func end() -> void:

	active_save_data = null

	Scenes.activate_scene(MainMenu)





func save() -> void:

	Saves.save_game(active_save_data)





func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().paused = false





func transition_to(location_id: StringName, spawn_id: StringName) -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	print(location_id)

	world_scene.enter_location(location_id, spawn_id)







func is_active() -> bool:

	return active_save_data != null



func is_paused() -> bool:

	return get_tree().paused



func get_player() -> PlayerNode:

	if !player:

		player = Entities.get_player_node()

		add_child(player)

		player._deactivate()

	return player



func get_save_data() -> SaveData:

	return active_save_data



func get_active_location() -> LocationScene:

	var world_scene = Scenes.get_scene(WorldScene)

	return world_scene.get_active_location()



func get_location_data(location_id: StringName) -> LocationData:

	for location_data in active_save_data.location_data_list:

		if location_data.location_id == location_id:

			return location_data

	return null

















func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave") and is_active():

		save()