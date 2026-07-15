extends Node






var active_save_data: SaveData









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

	var location_scene = world_scene.enter_location(active_save_data.get_last_location_id())





func end() -> void:

	active_save_data = null

	Scenes.activate_scene(MainMenu)





func save() -> void:

	Saves.save_game(active_save_data)









func is_active() -> bool:

	return active_save_data != null







func get_active_location() -> LocationScene:

	var world_scene = Scenes.get_scene(WorldScene)

	return world_scene.get_active_location()



func get_location_data(location_id: StringName) -> LocationData:

	for location_data in active_save_data.location_data_list:

		if location_data.location_id == location_id:

			return location_data

	return null