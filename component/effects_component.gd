class_name EffectsComponent extends Component





var active_effects: Array[Effect]










func add_effect(effect: Effect) -> void:

	if effect is InstantEffect:

		effect.apply_effect(entity)

		return

	active_effects.append(effect)







func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["active_effects"] = []

	for effect in active_effects:

		save_dict["active_effects"].append(effect._get_dictionary())

	return save_dict