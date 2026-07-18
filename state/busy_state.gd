class_name BusyState extends State




var movement_component: MovementComponent



func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)





func _enter() -> void:

	movement_component.can_move = false

	movement_component.halt()




func _exit() -> void:

	movement_component.can_move = true