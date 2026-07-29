class_name IsInLocationCondition extends Condition


@export var location_id: StringName


func evaluate(_data: Dictionary = {}) -> bool:

	if !_data.has("entity_node"):

		return false

	var entity_node = _data["entity_node"]

	var active_location = Scenes.get_active_location()

	if active_location.has_entity_node(entity_node):

		return false

	for location in Scenes.get_loaded_locations():

		if location.location_id == location_id:
		
			return location.has_entity_node(_data["entity_node"])

	return false

