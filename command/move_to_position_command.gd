class_name MoveToPositionCommand extends Command


@export var target_pos: Vector2



func execute(_data: Dictionary = {}) -> bool:

	var entity_node = _data["entity_node"]

	if _data.has("target_pos"):

		target_pos = _data["target_pos"]

	var navigation_component = entity_node.get_component(NavigationComponent)

	navigation_component.set_target_pos(target_pos)

	navigation_component.target_pos_reached.connect(_on_target_pos_reached, CONNECT_ONE_SHOT)

	return false




static func run(_data: Dictionary) -> bool:

	var command = MoveToPositionCommand.new()

	return command.execute(_data)





func _on_target_pos_reached() -> void:

	executed.emit()