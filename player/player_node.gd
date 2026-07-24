class_name PlayerNode extends CharacterNode

@export var entity_sensor: Sensor





func _initialize() -> bool:

	if super():

		entity_sensor.setup(self)

		return true

	return false