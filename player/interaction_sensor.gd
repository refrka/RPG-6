class_name InteractionSensor extends Sensor




var target_component: InteractableComponent





func setup(_entity: EntityNode = null) -> void:

	super(_entity)

	var input_component = entity.get_component("input")

	input_component.interact_pressed.connect(_on_interact_pressed)

	input_component.interact_released.connect(_on_interact_released)










func _try_interact(_target_component: InteractableComponent) -> void:

	pass









func _on_body_entered(body: PhysicsBody2D) -> void:

	for component in body.get_all_components():

		if component is InteractableComponent:

			super(body)







func _on_interact_pressed() -> void:

	pass






func _on_interact_released() -> void:

	pass