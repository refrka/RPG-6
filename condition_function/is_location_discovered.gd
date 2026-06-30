class_name IsLocationDiscovered extends ConditionFunction


@export var location_id: StringName




func evaluate(_data: Dictionary = {}) -> bool:

	var location_data = Game.get_location_data(location_id)

	return location_data != null