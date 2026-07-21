class_name InputComponent extends Component



signal interact_pressed

signal interact_released

signal profile_pressed

signal weapon_attack_pressed

signal weapon_attack_released





var movement_component: MovementComponent:

	get:

		if !movement_component:

			movement_component = entity.get_component(MovementComponent)
		
		return movement_component




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func enable() -> void:

	_activate()



func disable() -> void:

	_deactivate()






func _unhandled_input(event: InputEvent) -> void:

	if !active:

		return

	if event.is_action_pressed("interact"):

		interact_pressed.emit()

	if event.is_action_released("interact"):

		interact_released.emit()

	if event.is_action_pressed("profile"):

		profile_pressed.emit()

	if event.is_action_pressed("weapon_attack"):

		weapon_attack_pressed.emit()

	if event.is_action_released("weapon_attack"):

		weapon_attack_released.emit()





func _process(_delta: float) -> void:

	if !active:

		return


	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	movement_component.set_move_dir(input_dir)