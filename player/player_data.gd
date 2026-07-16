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