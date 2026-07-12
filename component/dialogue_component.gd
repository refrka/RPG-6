class_name DialogueComponent extends InteractableComponent









func interact() -> bool:

	if entity.def.dialogue_library:

		Events.fire(DialogueStartedEvent, {"entity_node": entity})

		var panel = UI.open_interaction_overlay(entity)

		panel.close_requested.connect(_on_close_requested)

		dialogue_open = true

		var greeting = get_greeting()

		panel.set_greeting(greeting)
			
		return true

	return false






func get_greeting(data:= {}) -> Greeting:

	var possible_greetings = []

	for greeting in entity.def.dialogue_library.greetings:

		if greeting.condition_set and !greeting.condition_set.evaluate(data):

			continue
		
		possible_greetings.append(greeting)

	return possible_greetings.back()