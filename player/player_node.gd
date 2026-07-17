class_name PlayerNode extends CharacterNode







func _initialize(entity_data: EntityData = null) -> void:

	super(entity_data)

	if entity_data != null and entity_data is PlayerData:

		_load_data(entity_data)

	else:

		data = PlayerData.new()

	Events.fire(PlayerInitializedEvent)





func _setup() -> void:

	super()

	Events.subscribe(PlayerEnteredLocationEvent, _on_player_entered_location)





func get_display_name() -> String:

	var save_data = Game.get_save_data()

	return save_data.save_name






func _on_player_entered_location(event: Event) -> void:

	var location_scene = event.data["location_scene"]

	var location_id = location_scene.location_id

	var spawn_id = event.data["spawn_id"]

	if !data.discovered_locations.has(location_id):

		data.discovered_locations.append(location_id)

		Events.fire(LocationDiscoveredEvent, event.data)

	_update_current_location(location_id, spawn_id)







func _update_current_location(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_save_data()

	save_data.current_location_id = location_id

	save_data.current_spawn_id = spawn_id






