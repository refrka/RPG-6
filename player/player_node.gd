class_name PlayerNode extends CharacterNode



var active_spawn_point: SpawnPoint

var active_location: Location




func _initialize() -> bool:

	super()

	Events.subscribe(PlayerEnteredLocationEvent, _on_player_entered_location)

	return true





func get_display_name() -> String:

	var save_data = Game.get_save_data()

	return save_data.save_name




func reset() -> void:

	inventory.clear()






func _get_dictionary() -> Dictionary:

	var save_dict = super()

	save_dict["spawn_id"] = active_spawn_point.spawn_id

	save_dict["location_id"] = active_location.location_id

	return save_dict








func _on_player_entered_location(event: Event) -> void:

	var location_id = event.data["location"].location_id

	if !Globals.is_in_list("discovered_locations", location_id):

		Globals.add_to_list("discovered_locations", location_id)

		Events.fire(LocationDiscoveredEvent, event.data)


