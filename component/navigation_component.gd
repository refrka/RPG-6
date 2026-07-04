class_name NavigationComponent extends Component





var movement_component: MovementComponent



var target_pos: Vector2




func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component("movement")






func set_target_pos(new_pos: Vector2) -> void:

	target_pos = new_pos

	entity.nav_agent.target_position = target_pos












func _process(_delta: float) -> void:

	if !active:

		return

	if entity.nav_agent.is_navigation_finished():

		movement_component.halt()

		return

	var move_dir = entity.global_position.direction_to(entity.nav_agent.get_next_path_position())

	movement_component.set_move_dir(move_dir)