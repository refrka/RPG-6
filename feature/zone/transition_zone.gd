class_name TransitionZone extends Zone


@export var target_location_id: StringName

@export var target_spawn_id: StringName







func _on_body_entered_sensor(_body: PhysicsBody2D) -> void:

	if !active:

		return

	# Transition logic

	_deactivate()