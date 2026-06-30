class_name MovementComponent extends Component



signal move_started

signal move_stopped



var move_dir: Vector2

var current_velocity: Vector2


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

		move_velocity = move_velocity.move_toward(move_dir * 250.0, 1200)

	if can_move:

		entity.velocity = move_velocity

		entity.move_and_slide()

	if current_velocity != Vector2.ZERO and move_velocity == Vector2.ZERO:

		move_stopped.emit()

	elif current_velocity == Vector2.ZERO and move_velocity != Vector2.ZERO:

		move_started.emit()

	if current_velocity != entity.velocity:

		current_velocity = entity.velocity




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact"):

		if entity.def.entity_id == "mim":

			entity.update_location("forest_start", "start")