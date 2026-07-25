class_name InteractingState extends BusyState




var movement_component: MovementComponent




func _setup(_entity: EntityNode) -> void:

	print("setup interactings tate")

	super(_entity)

	movement_component = entity.get_component(MovementComponent)




func _enter() -> void:

	movement_component._deactivate()





func _exit() -> void:

	movement_component._activate()