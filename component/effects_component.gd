class_name EffectsComponent extends Component





var active_effects: Array[Effect]










func add_effect(effect: Effect) -> void:

	if effect is InstantEffect:

		effect.apply_effect(entity)

		return

	active_effects.append(effect)