class_name Zone extends Feature


@export var sensor: Sensor






func _initialize() -> void:

	super()

	sensor.setup()

	if !sensor.body_entered.is_connected(_on_body_entered_sensor):

		sensor.body_entered.connect(_on_body_entered_sensor)




func _on_body_entered_sensor(_body: PhysicsBody2D) -> void:

	pass