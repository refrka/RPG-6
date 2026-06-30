class_name DiscoverLocationObjective extends QuestObjective





@export var location_id: StringName



func _initialize() -> void:

	Events.subscribe(LocationDiscoveredEvent, _on_location_discovered)



func _on_location_discovered(event: LocationDiscoveredEvent) -> void:

	if event.data["location_id"] == location_id:

		completed.emit(self)