class_name WorldScene extends GameScene




var active_location: LocationScene






func load_location(location_id: StringName) -> LocationScene:

	if active_location:

		unload_location()

	var location_scene = Scenes.get_location_scene(location_id)

	add_child(location_scene)

	active_location = location_scene

	return active_location






func unload_location() -> void:

	active_location.queue_free()