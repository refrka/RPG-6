class_name NavigationComponent extends Component


signal target_pos_reached


var movement_component: MovementComponent



var target_pos: Vector2




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if entity is PlayerNode:

		_deactivate()

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.target_reached.connect(_on_target_reached)







func set_target_pos(new_pos: Vector2) -> void:

	if target_pos == new_pos:

		return

	target_pos = new_pos

	entity.nav_agent.set_target_position(target_pos)





func halt() -> void:

	movement_component.halt()

	set_target_pos(entity.global_position)






func _on_target_reached() -> void:

	halt()




func _process(_delta: float) -> void:

	if !active:

		return

	if entity.nav_agent.is_navigation_finished():

		return

	var move_dir = entity.global_position.direction_to(entity.nav_agent.get_next_path_position())

	movement_component.set_move_dir(move_dir)