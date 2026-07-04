class_name RestoreHealthEffect extends InstantEffect



@export var amount: float





func apply_effect(target_entity: EntityNode) -> void:

	var health_component = target_entity.get_component("health")

	health_component.restore_health(amount)