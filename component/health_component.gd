class_name HealthComponent extends Component





signal health_restored(amount: float, new_health: float)

signal health_reduced(amount: float, new_health: float)

signal health_depleted



var max_health: float

var current_health: float






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var entity_def = entity.get_entity_def()

	max_health = entity_def.base_max_health

	current_health = max_health





func restore_health(amount: float) -> void:

	var new_health = min(max_health, current_health + amount)

	var restored_amount = new_health - current_health

	current_health = new_health

	health_restored.emit(restored_amount, current_health)

	if entity is PlayerNode:

		Events.fire(PlayerRestoredHealthEvent, {}, true)




func reduce_health(amount: float) -> void:

	var new_health = max(0, current_health - amount)

	var reduced_amount = current_health - new_health

	current_health = new_health

	health_reduced.emit(reduced_amount, current_health)

	if current_health == 0.0:

		health_depleted.emit()

		if entity is PlayerNode:

			Game.end()










func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["current_health"] = current_health

	save_dict["max_health"] = max_health

	return save_dict





func _load_dictionary(save_dict: Dictionary) -> void:

	current_health = save_dict["current_health"]

	max_health = save_dict["max_health"]