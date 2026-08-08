class_name ProjectileComponent extends Component



var movement_component: MovementComponent


var current_trajectory: Vector2





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)





func set_trajectory(new_trajectory: Vector2) -> void:

	current_trajectory = new_trajectory

	movement_component.set_move_dir(current_trajectory)





