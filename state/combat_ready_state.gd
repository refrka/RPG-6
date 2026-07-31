class_name CombatReadyState extends CombatState



var timer: SceneTreeTimer





func _enter() -> void:

	super()

	timer = Game.get_timer(2.5)

	timer.timeout.connect(_on_timeout)




func _exit() -> void:

	timer.time_left = 0.0

	timer.timeout.disconnect(_on_timeout)

	timer = null




func _on_timeout() -> void:

	entity.state_machine.request_state(IdleState)