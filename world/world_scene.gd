class_name WorldScene extends GameScene




var active_location: LocationScene

var location_data_list: Array[LocationData]





func load_location(location_id: StringName) -> LocationScene:

	var location_scene = Scenes.get_location_scene(location_id)

	if active_location and active_location != location_scene:

		unload_location()

	if !location_scene.is_inside_tree():

		add_child(location_scene)

	active_location = location_scene

	var location_data = _get_location_data(location_scene)

	active_location.load_location_data(location_data)

	return active_location






func unload_location() -> void:

	active_location.queue_free()











func _get_location_data(location_scene: LocationScene) -> LocationData:

	var data: LocationData = null

	var save_data = Game.get_save_data()

	for location_data in save_data.location_data_list:

		if location_data.location_scene == location_scene:

			data = location_data

	if data == null:

		data = _create_location_data(location_scene)

	return data






func _create_location_data(location_scene: LocationScene) -> LocationData:

	var data = LocationData.new()

	data.location_scene = location_scene

	var save_data = Game.get_save_data()

	save_data.location_data_list.append(data)

	return data