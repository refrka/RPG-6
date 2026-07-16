class_name PlayerData extends CharacterData


var discovered_locations: Array[StringName]







func _init() -> void:

	Events.subscribe(PlayerEnteredLocationEvent, _on_player_entered_location)




func _on_player_entered_location(event: Event) -> void:

	var location_scene = event.data["location_scene"]

	var location_id = location_scene.location_id

	if !discovered_locations.has(location_id):

		discovered_locations.append(location_id)

		Events.fire(LocationDiscoveredEvent, event.data)







func get_dictionary() -> Dictionary:

	var save_dict = super()

	save_dict["discovered_locations"] = discovered_locations

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> EntityData:

	var player_data = PlayerData.new()

	if save_dict.is_empty():

		return player_data

	player_data.discovered_locations.assign(save_dict["discovered_locations"])

	return player_data