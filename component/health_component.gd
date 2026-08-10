class_name HealthComponent extends Component





signal health_restored(amount: float, new_health: float)

signal health_reduced(amount: float, new_health: float)

signal health_depleted(final_damage_package: DamagePackage)



var max_health: float

var current_health: float




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED




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





func reduce_health(amount: float) -> void:

	if !entity.destructible:

		return

	var new_health = max(0, current_health - amount)

	var reduced_amount = current_health - new_health

	current_health = new_health

	health_reduced.emit(reduced_amount, current_health)

	if current_health == 0.0:

		pass





func receive_damage_package(damage_package: DamagePackage) -> bool:

	if !active:

		return false

	if entity.destructible:

		reduce_health(damage_package.total_damage)

		var animation_component = entity.get_component(AnimationComponent)

		animation_component.anim_tree.set("parameters/ShakeOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	for damage_set in damage_package.damage_sets:

		pass

	if !_is_alive():

		_die(damage_package)

	return true









func _die(final_damage_package: DamagePackage) -> void:

	health_depleted.emit(final_damage_package)

	






func _is_alive() -> bool:

	return current_health > 0.0










func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["current_health"] = current_health

	save_dict["max_health"] = max_health

	return save_dict





func _load_dictionary(save_dict: Dictionary) -> void:

	current_health = save_dict["current_health"]

	max_health = save_dict["max_health"]