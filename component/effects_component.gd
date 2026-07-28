class_name EffectsComponent extends Component




var active_effects: Array[Effect]





func add_effect(effect: Effect) -> void:

	if effect is InstantEffect:

		effect._apply(entity)

	else:

		_add_effect(effect)





func _add_effect(effect: Effect) -> void:

	active_effects.append(effect)

	effect.expired.connect(_on_effect_expired)

	effect._initialize(entity)





func _remove_effect(effect: Effect) -> void:

	active_effects.erase(effect)





func _on_effect_expired(effect: Effect) -> void:

	_remove_effect(effect)






func _process(delta: float) -> void:

	if !active:

		return

	for effect in active_effects:

		if effect.has_method("_process"):

			effect._process(delta)