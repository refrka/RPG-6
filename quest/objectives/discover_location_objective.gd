class_name DiscoverLocationObjective extends QuestObjective


@export var location_id: StringName





func _initialize() -> void:

	Events.subscribe(LocationDiscoveredEvent, _on_location_discovered)



func _complete() -> void:

	Events.unsubscribe(LocationDiscoveredEvent, _on_location_discovered)



func _is_complete() -> bool:

	var discovered_locations = Globals.get_var("discovered_locations")

	if discovered_locations.has(location_id):

		return true

	return false




func _on_location_discovered(event: Event) -> void:

	if location_id == event.data["location"].location_id:

		objective_complete.emit(self)


