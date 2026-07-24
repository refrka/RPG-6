class_name EntitySensor extends Sensor




var target_entity: EntityNode

var target_interactable_component: InteractableComponent

var timer:= 0.0



func setup(_entity: EntityNode = null) -> void:

	super(_entity)

	var input_component = entity.get_component(InputComponent)

	if !input_component:
		
		return

	input_component.interact_pressed.connect(_on_interact_pressed)

	input_component.interact_released.connect(_on_interact_released)





func try_start_interaction(_target_entity: EntityNode) -> void:

	var interactable_component = _target_entity.get_component(InteractableComponent)

	if !interactable_component:

		return

	if !interactable_component._can_interact():

		return

	start_interaction(_target_entity)




func try_end_interaction() -> void:

	end_interaction()





func start_interaction(_target_entity: EntityNode) -> void:

	target_entity = _target_entity

	target_interactable_component = target_entity.get_component(InteractableComponent)

	if target_interactable_component.duration > 0.0:

		hold_interaction()

	else:

		execute_interaction()




func execute_interaction() -> void:

	target_interactable_component._interact()





func end_interaction() -> void:

	pass




func hold_interaction() -> void:

	timer = target_interactable_component.duration





func _on_interact_pressed() -> void:

	var _target_entity = get_nearest_body()

	if !_target_entity:

		return

	if entity.state_machine.get_current_state() is InteractingState:

		pass

	else:

		try_start_interaction(_target_entity)





func _on_interact_released() -> void:

	pass







func _process(delta: float) -> void:

	if !active:

		return

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			timer = 0.0

			execute_interaction()