class_name NewWorldScene extends GameScene





var active_location: NewLocationScene


var location_registry: Dictionary[StringName, NewLocationScene]








func activate_location(location_id: StringName) -> NewLocationScene:

	var location_scene = get_location(location_id)

	if active_location:

		active_location._deactivate()

	return location_scene












func get_location(location_id: StringName) -> NewLocationScene:

	if location_registry.has(location_id):

		return location_registry[location_id]

	return null