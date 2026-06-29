class_name InteractionSensor extends Sensor




var target_component: InteractableComponent

var timer:= 0.0



func setup(_entity: EntityNode = null) -> void:

	super(_entity)

	var input_component = entity.get_component("input")

	input_component.interact_pressed.connect(_on_interact_pressed)

	input_component.interact_released.connect(_on_interact_released)












func _try_interact(_target_component: InteractableComponent) -> void:

	if _can_interact(_target_component):

		if !_is_interacting():
		
			target_component = _target_component

			_start_interaction()

		elif target_component and target_component.type == InteractableComponent.InteractionType.TOGGLE:

			_end_interaction()






func _start_interaction() -> void:

	if !target_component:

		return 

	if !_is_interacting():

		if target_component.interact():

			if !target_component.end_requested.is_connected(_on_end_requested_by_component):

				target_component.end_requested.connect(_on_end_requested_by_component)

			entity.state_machine.request_state("interacting")

			if target_component.duration > 0.0 and target_component.type == InteractableComponent.InteractionType.HOLD:

				timer = target_component.duration

			return

	_end_interaction()








func _end_interaction() -> void:

	timer = 0.0

	target_component.end()

	target_component = null

	entity.state_machine.request_state("idle")




func _cancel_interaction() -> void:

	_end_interaction()



func _complete_interaction() -> void:

	target_component.complete()

	_end_interaction()








func _get_interactable_component(entity_node: EntityNode) -> InteractableComponent:

	for component in entity_node.get_all_components():

		if component is InteractableComponent:

			return component

	return null






func _can_interact(interactable_component: InteractableComponent) -> bool:

	return true




func _is_interacting() -> bool:

	return entity.state_machine.current_state is InteractingState









func _on_body_entered(body: PhysicsBody2D) -> void:

	for component in body.get_all_components():

		if component is InteractableComponent:

			super(body)







func _on_interact_pressed() -> void:

	var nearest_body = get_nearest_body()

	if !nearest_body:

		return

	var interactable_component = _get_interactable_component(nearest_body)

	_try_interact(interactable_component)




func _on_interact_released() -> void:

	if _is_interacting() and target_component.type == InteractableComponent.InteractionType.HOLD:

		_cancel_interaction()






func _on_end_requested_by_component() -> void:

	_end_interaction()





func _process(delta: float) -> void:

	if !_is_interacting():

		return

	if timer > 0.0:

		timer -= delta

		print(timer)

		if timer <= 0.0:

			timer = 0.0

			_complete_interaction()



