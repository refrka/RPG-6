class_name InputComponent extends Component






var movement_component: MovementComponent:

	get:

		if !movement_component:

			movement_component = entity.get_component("movement")
		
		return movement_component









func _process(_delta: float) -> void:

	if !active:

		return

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	movement_component.set_move_dir(input_dir)