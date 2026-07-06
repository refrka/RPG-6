class_name MoveToPosition extends CommandFunction



@export var target_pos: Vector2

@export var entity_marker_id: StringName




func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	if !data.has("actor"):

		return false

	var entity = data["actor"]

	var navigation_component = entity.get_component("navigation")

	if data.has("target_pos"):

		target_pos = data["target_pos"]

	if data.has("entity_marker_id"):

		entity_marker_id = data["entity_marker_id"]

	if entity_marker_id == &"":

		navigation_component.set_target_pos(target_pos)

	else:

		var location_scene = Scenes.get_scene(LocationScene)

		var marker = location_scene.get_entity_marker(entity_marker_id)

		navigation_component.set_target_pos(marker.global_position)

	return true