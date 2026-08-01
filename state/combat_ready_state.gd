class_name CombatReadyState extends CombatState


signal ready_timeout


var timer: SceneTreeTimer




func _setup(_entity: EntityNode) -> void:

	super(_entity)




func _enter() -> void:

	super()

	timer = Game.get_timer(2.5)

	timer.timeout.connect(_on_timeout)

	animation_component.set_blend_space_vector("ready_idle", movement_component.face_dir)

	animation_component.set_blend_space_vector("ready_move", movement_component.face_dir)

	animation_component.set_blend_space_vector("idle", movement_component.face_dir)

	movement_component.move_started.connect(_on_move_started)

	movement_component.move_stopped.connect(_on_move_stopped)




func _exit() -> void:

	super()

	timer.time_left = 0.0

	timer.timeout.disconnect(_on_timeout)

	timer = null

	movement_component.move_started.disconnect(_on_move_started)

	movement_component.move_stopped.disconnect(_on_move_stopped)




func _on_timeout() -> void:

	ready_timeout.emit()

	entity.state_machine.request_state(IdleState)




func _on_move_started() -> void:

	animation_component.anim_tree.set("parameters/RootState/CombatState/CombatReadyTree/ReadyMoveAdd/add_amount", 1.0)

	animation_component.set_blend_space_vector("ready_move", movement_component.face_dir)




func _on_move_stopped() -> void:

	animation_component.anim_tree.set("parameters/RootState/CombatState/CombatReadyTree/ReadyMoveAdd/add_amount", 0.0)

	animation_component.set_blend_space_vector("ready_idle", movement_component.face_dir)