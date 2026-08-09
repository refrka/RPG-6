class_name Hitbox extends Sensor



signal hit_detected(entity_node: EntityNode)



@export var collision_shape: CollisionShape2D


var hit_list: Array[Hurtbox]





func clear_hit_list() -> void:

	hit_list.clear()




func _on_area_entered(area: Area2D) -> void:

	area = area as Hurtbox

	if area.entity == entity:

		return

	if hit_list.has(area):

		return

	hit_list.append(area)

	hit_detected.emit(area.entity)




