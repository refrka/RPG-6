class_name MovementComponent extends Component





var move_dir: Vector2



var can_move:= true










func set_move_dir(dir: Vector2) -> void:

	move_dir = dir





func halt() -> void:

	set_move_dir(Vector2.ZERO)

	entity.velocity = Vector2.ZERO
















func _process(_delta: float) -> void:

	if !active:

		return

	var move_velocity = entity.velocity

	if move_dir == Vector2.ZERO:

		move_velocity = move_velocity.move_toward(Vector2.ZERO, 1500)

	else:

		move_velocity = move_velocity.move_toward(move_dir * 150.0, 1200)

	if can_move:

		entity.velocity = move_velocity

		entity.move_and_slide()