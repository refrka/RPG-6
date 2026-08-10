class_name ProjectileComponent extends Component


signal expired

signal hit_detected



var movement_component: MovementComponent

var current_trajectory: Vector2

var expire_timer: SceneTreeTimer






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	entity.combat_hitbox.hit_detected.connect(_on_hit_detected)





func set_trajectory(new_trajectory: Vector2) -> void:

	current_trajectory = new_trajectory

	movement_component.set_move_dir(current_trajectory)






func _on_expire_timeout() -> void:

	expired.emit()



func _on_hit_detected(entity_node: EntityNode) -> void:

	if entity_node == entity.projectile_owner:

		return

	hit_detected.emit(entity_node)

	# entity_node.add_visual_node.call_deferred(entity)

	movement_component.halt()

	if !expire_timer:

		expire_timer = Game.get_timer(2.5)

		expire_timer.timeout.connect(_on_expire_timeout)




func _process(_delta: float) -> void:

	if !active or !movement_component.is_moving():

		return

	var slide_collision_count = entity.get_slide_collision_count()

	if slide_collision_count > 0:

		movement_component.halt()

		expire_timer = Game.get_timer(2.5)

		expire_timer.timeout.connect(_on_expire_timeout)






