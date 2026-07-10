class_name GameCamera extends Camera2D
















func tween_position_to(target_position: Vector2, duration: float) -> void:

	var tween = get_tree().create_tween()

	tween.tween_property(self, "position", target_position, duration)