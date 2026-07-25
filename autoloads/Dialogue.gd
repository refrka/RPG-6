extends Node


signal dialogue_ended


var dialogue_panel: DialoguePanel

var greeting_pool: Array[Greeting]



var current_source: EntityNode




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	dialogue_panel = UI.get_overlay(DialoguePanel)

	dialogue_panel.panel_closed.connect(_on_dialogue_panel_closed)







func start_dialogue(greeting: Greeting, options: Array[DialogueNode] = [], source: EntityNode = null) -> void:

	current_source = source

	UI.show_dialogue_panel(greeting, options, source)

	Events.fire(DialogueStartedEvent, {"source": current_source})




func end_dialogue() -> void:

	UI.close_dialogue_panel()

	Events.fire(DialogueEndedEvent, {"source": current_source})

	dialogue_ended.emit()

	current_source = null






func get_greeting(source: EntityNode, options: Array[DialogueNode]) -> Greeting:

	var unevaluated_greetings = greeting_pool.duplicate()

	var evaluated_greetings: Array[Greeting] = []

	var entity_def = source.get_entity_def()

	if entity_def.dialogue_library:

		unevaluated_greetings.append_array(entity_def.dialogue_library.default_greetings)

	for dialogue_node in options:

		if dialogue_node.forced_greeting != null:

			return dialogue_node.forced_greeting

	for greeting in unevaluated_greetings:

		if greeting.show_condition_set and greeting.show_condition_set.evaluate():

			evaluated_greetings.append(greeting)

		elif !greeting.show_condition_set:

			evaluated_greetings.append(greeting)

	if evaluated_greetings.is_empty():

		return null

	return evaluated_greetings.front()





func get_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	var unevaluated_dialogue_nodes: Array[DialogueNode] = []

	var evaluated_dialogue_nodes: Array[DialogueNode] = []

	unevaluated_dialogue_nodes.append_array(_get_library_dialogue_nodes(source))

	return evaluated_dialogue_nodes





func _get_library_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	var entity_def = source.get_entity_def()

	if entity_def.dialogue_library:

		return entity_def.dialogue_library.default_dialogue_nodes

	return []






func _get_quest_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	return []





func _on_dialogue_panel_closed() -> void:

	end_dialogue()





func _load_greeting_pool() -> void:

	var dir = "res://dialogue/greetings/"

	for file_name in ResourceLoader.list_directory(dir):

		var path = dir + file_name

		var greeting = load(path) as Greeting

		greeting_pool.append(greeting)