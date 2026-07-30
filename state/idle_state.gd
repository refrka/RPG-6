class_name IdleState extends State



var movement_component: MovementComponent

var default_playback: AnimationNodeStateMachinePlayback




func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.move_started.connect(_on_move_started)

	default_playback = animation_component.get_state_playback("default")




func _enter() -> void:

	default_playback.start("IdleTree")

	if movement_component:

		animation_component.set_blend_space_vector("idle", movement_component.face_dir)

	




func _on_move_started() -> void:

	entity.state_machine.request_state(MovingState)


