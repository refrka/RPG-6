class_name ExitLocationCommand extends Command




func execute(_data: Dictionary = {}) -> bool:

	var entity_node = _data["entity_node"]

	var world_scene = Scenes.get_world_scene()

	var location = world_scene.get_active_location()

	location.remove_entity_node.call_deferred(entity_node)

	return super()