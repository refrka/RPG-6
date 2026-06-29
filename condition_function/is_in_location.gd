class_name IsInLocation extends ConditionFunction




@export var location_id: StringName







func evaluate(_data: Dictionary = {}) -> bool:

	if _data.has("location_id"):

		location_id = _data["location_id"]

	var location_scene = Scenes.get_scene(LocationScene)

	if !location_scene or location_scene.location_id != location_id:

		return false

	return true