class_name IdleState extends State



var movement_component: MovementComponent

var navigation_component: NavigationComponent



func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.move_started.connect(_on_move_started)

	navigation_component = entity.get_component(NavigationComponent)








func _enter() -> void:

	super()
	
	if animation_component.get_playback_node("root") != "DefaultState":

		animation_component.travel_playback("root", "DefaultState")

	if navigation_component:

		if navigation_component.has_destination():

			print("mim has a destination")

			entity.state_machine.request_state(MovingState)

			return

	animation_component.travel_playback("default", "IdleTree")

	




func _on_move_started() -> void:

	if !active:

		return

	entity.state_machine.request_state(MovingState)



