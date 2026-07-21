class_name WorldScene extends GameScene








var active_location: Location

var paused_locations: Array[Location]

















func activate_location(location_id: StringName, pause_current:= false) -> Location:

	if !active:

		Scenes.activate_scene(WorldScene)

	if active_location:
		
		active_location._deactivate()

		if pause_current:

			pause_location(active_location)

		remove_child(active_location)

	var new_location = Scenes.get_location(location_id)

	add_child(new_location)

	active_location = new_location

	if active_location.is_paused():

		unpause_location(active_location)

	active_location._activate()

	return active_location





func pause_location(location: Location) -> void:

	location.pause()

	paused_locations.append(location)




func unpause_location(location: Location) -> void:

	location.resume()

	paused_locations.erase(location)








func get_active_location() -> Location:

	return active_location



func get_paused_locations() -> Array[Location]:

	return paused_locations



func get_all_locations() -> Array[Location]:

	var all_locations: Array[Location] = paused_locations

	if active_location:

		all_locations.append(active_location)

	return all_locations