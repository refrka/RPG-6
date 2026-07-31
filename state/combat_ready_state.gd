class_name CombatReadyState extends CombatState


signal ready_timeout


var timer: SceneTreeTimer





func _enter() -> void:

	super()

	timer = Game.get_timer(2.5)

	timer.timeout.connect(_on_timeout)

	animation_component.set_blend_space_vector("ready", movement_component.face_dir)

	animation_component.set_blend_space_vector("idle", movement_component.face_dir)




func _exit() -> void:

	timer.time_left = 0.0

	timer.timeout.disconnect(_on_timeout)

	timer = null




func _on_timeout() -> void:

	ready_timeout.emit()

	entity.state_machine.request_state(IdleState)