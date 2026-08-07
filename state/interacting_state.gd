class_name InteractingState extends BusyState




var movement_component: MovementComponent




func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)




func _enter() -> void:

	super()

	animation_component.travel_playback("default", "IdleTree")

	movement_component.can_move = false





func _exit() -> void:

	super()

	movement_component.can_move = true