class_name Hitbox extends Sensor


signal hit_detected(entity_node: EntityNode)





func _on_area_entered(area: Area2D) -> void:


	area = area as Hurtbox
	if area.entity == entity:

		return

	hit_detected.emit(area.entity)