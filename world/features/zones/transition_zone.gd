class_name TransitionZone extends Zone



@export var location_id: StringName

@export var spawn_id: StringName




func _initialize(_location_scene: LocationScene) -> void:

	super(_location_scene)

	if !sensor.body_entered.is_connected(_on_body_entered_zone):

		sensor.body_entered.connect(_on_body_entered_zone)





func _on_body_entered_zone(body: PhysicsBody2D) -> void:

	if !active:

		return

	if body is PlayerNode:

		Game.change_location.call_deferred(location_id, spawn_id)

		_deactivate()