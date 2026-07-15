class_name WorldScene extends GameScene



var loaded_locations: Array[LocationScene]

var active_location: LocationScene









func enter_location(location_id: StringName, spawn_id: StringName) -> LocationScene:

	var location_scene = load_location(location_id)

	change_active_location(location_scene)

	var player = Game.get_player()

	location_scene.spawn_entity(player, spawn_id)

	return location_scene







func load_location(location_id: StringName) -> LocationScene:

	var location_scene = get_loaded_location(location_id)

	if location_scene != null:

		return location_scene

	location_scene = Scenes.get_location_scene(location_id)

	return location_scene






func change_active_location(new_location: LocationScene) -> void:

	if active_location:

		active_location._exit()

		remove_child(active_location)

	active_location = new_location

	add_child(active_location)

	active_location._enter()






func get_loaded_location(location_id: StringName) -> LocationScene:

	for location_scene in loaded_locations:

		if location_scene.location_id == location_id:

			return location_scene

	return null






func get_active_location() -> LocationScene:

	return active_location