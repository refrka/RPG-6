class_name HealthComponent extends Component



signal health_restored(amount: float, current_health: float, max_health: float)

signal health_reduced(amount: float, current_health: float, max_health: float)

signal died



var current_health:= 1.0

var max_health:= 1.0








func _setup(_entity: EntityNode) -> void:

	super(_entity)

	max_health = entity.def.base_health

	current_health = max_health





func restore_health(amount: float) -> void:

	var remaining_health = max_health - current_health

	if amount > remaining_health:

		current_health = max_health

		health_restored.emit(remaining_health, current_health, max_health)

	else:

		current_health += amount

		health_reduced.emit(amount, current_health, max_health)





func reduce_health(amount: float) -> void:

	if amount < current_health:

		current_health -= amount

		health_reduced.emit(amount, current_health, max_health)

	else:

		current_health = 0.0

		health_reduced.emit(current_health, current_health, max_health)

		died.emit()

