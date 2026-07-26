extends Node


signal dialogue_ended


var dialogue_panel: DialoguePanel

var greeting_pool: Array[Greeting]



var current_source: EntityNode

var current_dialogue_node: DialogueNode



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	dialogue_panel = UI.get_overlay(DialoguePanel)

	dialogue_panel.close_requested.connect(_on_dialogue_close_requested)

	dialogue_panel.option_selected.connect(_on_option_selected)







func start_dialogue(greeting: Greeting, options: Array[DialogueNode] = [], source: EntityNode = null) -> void:

	current_source = source

	UI.show_dialogue_panel(greeting, options, source)

	Events.fire(DialogueStartedEvent, {"source": current_source})




func end_dialogue() -> void:

	if current_source != null:

		Events.fire(DialogueEndedEvent, {"source": current_source})

		current_source = null

		UI.close_dialogue_panel()

		dialogue_ended.emit()





func show_dialogue_node(dialogue_node: DialogueNode, source: EntityNode = null) -> void:

	if !source:

		source = current_source

	if current_dialogue_node:

		current_dialogue_node.exit()

	current_dialogue_node = dialogue_node

	var options: Array[DialogueNode] = current_dialogue_node.option_nodes

	current_dialogue_node.enter()

	if options.is_empty():

		options = get_dialogue_nodes(source)

	dialogue_panel.set_dialogue(source, current_dialogue_node.dialogue_text, options)




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

	unevaluated_dialogue_nodes.append_array(Quests.get_quest_dialogue_nodes(source))

	for dialogue_node in unevaluated_dialogue_nodes:

		if !dialogue_node.show_condition_set:
			
			evaluated_dialogue_nodes.append(dialogue_node)

		elif dialogue_node.show_condition_set.evaluate({"entity_node": source}):

			evaluated_dialogue_nodes.append(dialogue_node)

	return evaluated_dialogue_nodes







func _get_library_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	var entity_def = source.get_entity_def()

	if entity_def.dialogue_library:

		return entity_def.dialogue_library.default_dialogue_nodes

	return []






func _get_quest_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	return []





func _on_dialogue_close_requested() -> void:

	end_dialogue()




func _on_option_selected(dialogue_node: DialogueNode) -> void:

	show_dialogue_node(dialogue_node)





func _load_greeting_pool() -> void:

	var dir = "res://dialogue/greetings/"

	for file_name in ResourceLoader.list_directory(dir):

		var path = dir + file_name

		var greeting = load(path) as Greeting

		greeting_pool.append(greeting)




