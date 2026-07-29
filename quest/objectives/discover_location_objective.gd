class_name DiscoverLocationObjective extends QuestObjective


@export var location_id: StringName





func _initialize() -> void:

	Events.subscribe(LocationDiscoveredEvent, _on_location_discovered)



func _complete() -> void:

	Events.unsubscribe(LocationDiscoveredEvent, _on_location_discovered)



func _is_complete() -> bool:

	if Globals.is_in_list("discovered_locations", location_id):

		return true

	return false




func _on_location_discovered(event: Event) -> void:

	if location_id == event.data["location"].location_id:

		objective_complete.emit(self)


