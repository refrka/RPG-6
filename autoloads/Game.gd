extends Node






var active_save_data: SaveData




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

	world_scene.load_location(active_save_data.last_dict["location_id"])





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

	Scenes.load_scene(MainMenu)





func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().paused = false












func is_active() -> bool:

	return active_save_data != null


func is_paused() -> bool:

	return get_tree().paused











func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		save()