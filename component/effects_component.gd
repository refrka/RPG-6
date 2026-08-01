class_name EffectsComponent extends Component




var active_effects: Array[Effect]





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	process_mode = Node.PROCESS_MODE_DISABLED





func receive_damage_package(damage_package: DamagePackage) -> bool:

	if !active:

		return false

	return true





func add_effect(effect: Effect) -> void:

	if effect is InstantEffect:

		effect._apply(entity)

	else:

		_add_effect(effect)





func _add_effect(effect: Effect) -> void:

	active_effects.append(effect)

	effect.expired.connect(_on_effect_expired)

	effect._initialize(entity)
	
	process_mode = Node.PROCESS_MODE_INHERIT





func _remove_effect(effect: Effect) -> void:

	active_effects.erase(effect)

	if active_effects.is_empty():

		process_mode = Node.PROCESS_MODE_DISABLED





func _on_effect_expired(effect: Effect) -> void:

	_remove_effect(effect)






func _process(delta: float) -> void:

	if !active:

		return

	for effect in active_effects:

		if effect.has_method("_process"):

			effect._process(delta)