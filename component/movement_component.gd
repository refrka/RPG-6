class_name MovementComponent extends Component



signal move_started

signal move_stopped



var move_speed_override:= -1.0

var move_dir: Vector2

var current_velocity: Vector2


var can_move:= true





func _initialize(_entity: EntityNode) -> void:

	super(_entity)





func enable() -> void:

	_activate()



func disable() -> void:

	_deactivate()





func set_move_dir(dir: Vector2) -> void:

	move_dir = dir



func set_move_speed_override(override: float) -> void:

	move_speed_override = override


func remove_move_speed_override() -> void:

	move_speed_override = -1.0




func halt() -> void:

	set_move_dir(Vector2.ZERO)

	entity.velocity = Vector2.ZERO






func _stop_move() -> void:

	move_stopped.emit()




func _start_move() -> void:

	move_started.emit()









func _process(_delta: float) -> void:

	if !active:

		return

	var move_velocity = entity.velocity

	if move_dir == Vector2.ZERO:

		move_velocity = move_velocity.move_toward(Vector2.ZERO, 1500)

	else:

		var move_speed = entity.get_entity_def().move_speed

		if move_speed_override > 0.0:

			move_speed = move_speed_override

		move_velocity = move_velocity.move_toward(move_dir * move_speed, 1200)

	if can_move:

		entity.velocity = move_velocity

		entity.move_and_slide()

	if current_velocity != Vector2.ZERO and move_velocity == Vector2.ZERO:

		_stop_move()

	elif current_velocity == Vector2.ZERO and move_velocity != Vector2.ZERO:

		_start_move()

	if current_velocity != entity.velocity:

		current_velocity = entity.velocity


