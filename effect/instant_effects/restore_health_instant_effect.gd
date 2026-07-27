class_name RestoreHealthInstantEffect extends InstantEffect



@export var value:= 0.0





func _apply(_target_entity: EntityNode = null) -> void:

	super(_target_entity)

	var health_component = target_entity.get_component(HealthComponent)

	health_component.restore_health(value)