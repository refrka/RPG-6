extends Node






var active_save_data: SaveData

var player: PlayerNode



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





## Top-level Methods


func launch() -> void:

	Scenes.load_scene(MainMenu)





func start(save_id: StringName) -> void:

	if active_save_data:

		end()

	active_save_data = Saves.load_save_data(save_id)

	var world_scene = Scenes.load_scene(WorldScene)

	var location_scene = world_scene.load_location(active_save_data.last_dict["location_id"])

	location_scene.spawn_player(active_save_data.last_dict["spawn_id"])





func end() -> void:

	save()

	active_save_data = null





func save() -> void:

	if !active_save_data:

		return

	Saves.save_game(active_save_data)

	print("Game saved (%s : %s)" % [active_save_data.save_name, active_save_data.save_id])





func exit() -> void:

	end()

	Scenes.close_scene(LocationScene)

	Scenes.load_scene(MainMenu)





func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().paused = false






func change_location(location_id: StringName, spawn_id:="start") -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	var location_scene = world_scene.load_location(location_id)

	location_scene.spawn_player(spawn_id)

	active_save_data.location_id = location_id

	active_save_data.spawn_id = spawn_id

	




func get_player() -> PlayerNode:

	if !player:

		player = load("res://player/player_node.tscn").instantiate()

		add_child(player)
	
	return player



func get_save_data() -> SaveData:

	return active_save_data



func get_location_data(location_id: StringName) -> LocationData:

	return active_save_data.get_location_data(location_id)



func get_entity_data(unique_id: StringName) -> EntityData:

	return active_save_data.get_entity_data(unique_id)





func is_active() -> bool:

	return active_save_data != null


func is_paused() -> bool:

	return get_tree().paused











func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		save()