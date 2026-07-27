class_name TransitionZone extends Zone


@export var target_location_id: StringName

@export var target_spawn_id: StringName



@export var spawn_point: SpawnPoint





func get_spawn_point_id() -> StringName:

	return spawn_point.spawn_id



func get_spawn_point() -> SpawnPoint:

	return spawn_point





func _on_body_entered_sensor(_body: PhysicsBody2D) -> void:

	if active:

		Game.transition_to.call_deferred(target_location_id, target_spawn_id)

	_deactivate()