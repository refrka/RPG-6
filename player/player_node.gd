class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor











func _initialize() -> void:

	super()

	interaction_sensor.setup(self)