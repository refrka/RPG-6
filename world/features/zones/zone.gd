class_name Zone extends Feature



@export var sensor: Sensor





func _setup(_location_scene: LocationScene) -> void:

	super(_location_scene)

	sensor.setup()