class_name RestoreHealthDurationEffect extends DurationEffect


@export var value: float






func _tick() -> void:

	super()

	var health_component = target_entity.get_component(HealthComponent)

	health_component.restore_health(value)