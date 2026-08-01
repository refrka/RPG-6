class_name CharacterNode extends EntityNode


@export var vision_sensor: Sensor



func _initialize() -> bool:

	if !super():

		return false

	vision_sensor.setup(self)

	return true