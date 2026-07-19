class_name NavigateToPosition extends Command


@export var target_pos: Vector2




func execute(_data: Dictionary = {}) -> bool:

	if _data.has("target_pos"):

		target_pos = _data["target_pos"]

	var entity_node = _data["entity_node"]

	var navigation_component = entity_node.get_component(NavigationComponent)

	navigation_component.set_target_pos(target_pos)

	return true