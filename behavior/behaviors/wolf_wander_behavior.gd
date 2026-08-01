class_name WolfWanderBehavior extends WanderBehavior





func _start() -> void:

	entity.vision_sensor.body_entered.connect(_on_body_entered_vision_sensor)
	
	super()






func _on_body_entered_vision_sensor(body: PhysicsBody2D) -> void:

	print(body)