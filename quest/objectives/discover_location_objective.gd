class_name DiscoverLocationObjective extends QuestObjective





@export var location_id: StringName



func _initialize() -> void:

	var location_data = Game.get_location_data(location_id)

	print("initializing quest objective: discover location objective")

	if location_data != null:

		completed.emit(self)

	Events.subscribe(LocationDiscoveredEvent, _on_location_discovered)






func _on_location_discovered(event: LocationDiscoveredEvent) -> void:

	if event.data["location_id"] == location_id:

		completed.emit(self)