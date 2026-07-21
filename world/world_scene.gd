class_name WorldScene extends GameScene








var active_location: Location

var paused_locations: Array[Location]















func get_active_location() -> Location:

	return active_location



func get_paused_locations() -> Array[Location]:

	return paused_locations



func get_all_locations() -> Array[Location]:

	var all_locations: Array[Location] = paused_locations

	if active_location:

		all_locations.append(active_location)

	return all_locations