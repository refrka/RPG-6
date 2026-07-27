class_name WorldScene extends GameScene








var active_location: Location

var loaded_locations: Array[Location]

var paused_locations: Array[Location]











func load_location(location_id: StringName) -> Location:

	var new_location = Scenes.get_location(location_id)

	new_location._initialize()

	new_location._deactivate()

	loaded_locations.append(new_location)

	return new_location





func unload_location(location: Location = null) -> void:

	if !location:

		location = active_location

	location._unload()

	location._deactivate()

	loaded_locations.erase(location)

	if location.is_paused():

		paused_locations.erase(location)

	if location == active_location:

		active_location = null

	location.queue_free()





func activate_location(location_id: StringName, pause_current:= false) -> Location:

	if !active:

		Scenes.activate_scene(WorldScene)

	if active_location:
		
		active_location._deactivate()

		if pause_current:

			pause_location(active_location)

		remove_child(active_location)

	var new_location = load_location(location_id)

	add_child(new_location)

	active_location = new_location

	if active_location.is_paused():

		unpause_location(active_location)

	active_location._activate()

	return active_location





func pause_location(location: Location) -> void:

	location.pause()

	paused_locations.append(location)

	if location == active_location:

		remove_child(location)

		active_location = null




func unpause_location(location: Location, activate:= false) -> void:

	location.resume()

	paused_locations.erase(location)

	if activate:

		activate_location(location.location_id)








func get_active_location() -> Location:

	return active_location



func get_loaded_locations() -> Array[Location]:

	return loaded_locations



func get_paused_locations() -> Array[Location]:

	return paused_locations



func get_all_locations() -> Array[Location]:

	var all_locations: Array[Location] = []

	all_locations.append_array(loaded_locations)

	all_locations.append_array(paused_locations)

	if active_location:

		all_locations.append(active_location)

	return all_locations