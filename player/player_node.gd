class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor







func _enter_tree() -> void:

	super()

	interaction_sensor.setup(self)