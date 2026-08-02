extends Node


signal dialogue_ended


@onready var default_barter_dialogue_node:= preload("res://dialogue/default_barter_dialogue_node.tres") as BarterDialogueNode


var dialogue_panel: DialoguePanel

var barter_panel: BarterPanel

var greeting_pool: Array[Greeting]



var current_source: EntityNode

var current_dialogue_node: DialogueNode




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	dialogue_panel = UI.get_overlay(DialoguePanel)

	barter_panel = UI.get_overlay(BarterPanel)

	dialogue_panel.close_requested.connect(_on_dialogue_close_requested)

	dialogue_panel.option_selected.connect(_on_option_selected)

	dialogue_panel.barter_selected.connect(_on_barter_selected)

	barter_panel.close_requested.connect(_on_barter_close_requested)







func start_dialogue(unevaluated_options: Array[DialogueNode] = [], source: EntityNode = null) -> void:

	current_source = source

	Events.fire(DialogueStartingEvent, {"entity_node": current_source})

	var evaluated_options = _evaluate_dialogue_nodes(unevaluated_options, {"entity_node": current_source})

	var greeting = get_greeting(source, evaluated_options)

	UI.show_dialogue_panel(greeting, evaluated_options, source)

	current_source.state_machine.request_state(InteractingState)

	if source.is_unique():

		if !Globals.is_in_list("greeted_characters", source.get_unique_id()):

			Globals.add_to_list("greeted_characters", source.get_unique_id())

	Events.fire(DialogueStartedEvent, {"entity_node": current_source})
		




func end_dialogue() -> void:

	if current_source != null:

		current_source.state_machine.request_state(IdleState)

		Events.fire(DialogueEndedEvent, {"entity_node": current_source})

		var dialogue_source = current_source

		current_source = null

		if current_dialogue_node:

			current_dialogue_node.exit({"entity_node": dialogue_source})

			current_dialogue_node = null

		UI.close_dialogue_panel()

		dialogue_ended.emit()




func show_dialogue_node(dialogue_node: DialogueNode, source: EntityNode = null) -> void:

	if !source:

		source = current_source

	if current_dialogue_node:

		current_dialogue_node.exit()

	current_dialogue_node = dialogue_node

	var options: Array[DialogueNode] = current_dialogue_node.option_nodes

	current_dialogue_node.enter({"entity_node": source})

	var evaluated_options = _evaluate_dialogue_nodes(options, {"entity_node": source})

	dialogue_panel.set_dialogue(source, current_dialogue_node.dialogue_text, evaluated_options)




func get_greeting(source: EntityNode, options: Array[DialogueNode]) -> Greeting:

	var unevaluated_greetings = greeting_pool.duplicate()

	var evaluated_greetings: Array[Greeting] = []

	var interactable_component = source.get_component(InteractableComponent)

	if interactable_component.dialogue_library:

		unevaluated_greetings.append_array(interactable_component.dialogue_library.default_greetings)

	var entity_def = source.get_entity_def()

	if entity_def.dialogue_library:

		unevaluated_greetings.append_array(entity_def.dialogue_library.default_greetings)

	for dialogue_node in options:

		if dialogue_node.show_condition_set and !dialogue_node.show_condition_set.evaluate({"entity_node": source}):

			continue

		if dialogue_node.forced_greeting != null:

			return dialogue_node.forced_greeting

	for greeting in unevaluated_greetings:

		if greeting.show_condition_set and greeting.show_condition_set.evaluate({"entity_node": source}):

			evaluated_greetings.append(greeting)

		elif !greeting.show_condition_set:

			evaluated_greetings.append(greeting)

	if evaluated_greetings.is_empty():

		return null

	return evaluated_greetings.front()





func get_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	var dialogue_nodes: Array[DialogueNode] = []

	dialogue_nodes.append_array(_get_library_dialogue_nodes(source))

	dialogue_nodes.append_array(Quests.get_quest_dialogue_nodes(source))

	var barter_component = source.get_component(BarterComponent)

	if barter_component:

		dialogue_nodes.append(default_barter_dialogue_node)

	return dialogue_nodes







func _evaluate_dialogue_nodes(unevaluate_dialogue_nodes: Array[DialogueNode], data: Dictionary) -> Array[DialogueNode]:

	var evaluated_dialogue_nodes: Array[DialogueNode] = []

	for dialogue_node in unevaluate_dialogue_nodes:

		var valid = true

		if !dialogue_node.can_show():

			valid = false

		else:

			if dialogue_node is QuestDialogueNode:

				var quest_def = Quests.get_quest_def(dialogue_node.quest_id)

				var quest_state = Quests.get_quest_state(quest_def)

				match dialogue_node.type:

					QuestDialogueNode.QuestDialogueNodeType.SOURCE:

						if quest_state != QuestData.QuestState.UNKNOWN and quest_state != QuestData.QuestState.AVAILABLE:

							valid = false

					QuestDialogueNode.QuestDialogueNodeType.OBJECTIVE:

						pass

					QuestDialogueNode.QuestDialogueNodeType.RECIPIENT:

						if quest_state != QuestData.QuestState.READY:

							valid = false

		if valid:

			if dialogue_node.show_condition_set:

				if !dialogue_node.show_condition_set.evaluate(data):

					continue
				
			evaluated_dialogue_nodes.append(dialogue_node)

	return evaluated_dialogue_nodes






func _get_library_dialogue_nodes(source: EntityNode) -> Array[DialogueNode]:

	var entity_def = source.get_entity_def()

	var dialogue_nodes: Array[DialogueNode] = []

	if entity_def.dialogue_library:

		dialogue_nodes.append_array(entity_def.dialogue_library.default_dialogue_nodes)

	var interactable_component = source.get_component(InteractableComponent)

	if interactable_component.dialogue_library:

		dialogue_nodes.append_array(interactable_component.dialogue_library.default_dialogue_nodes)

	return dialogue_nodes









func _on_dialogue_close_requested() -> void:

	end_dialogue()



func _on_barter_close_requested() -> void:

	UI.close_barter_panel()



func _on_option_selected(dialogue_node: DialogueNode) -> void:

	show_dialogue_node(dialogue_node)



func _on_barter_selected(barter_dialogue_node: BarterDialogueNode) -> void:

	UI.show_barter_panel(current_source, barter_dialogue_node)





func _load_greeting_pool() -> void:

	var dir = "res://dialogue/greetings/"

	for file_name in ResourceLoader.list_directory(dir):

		var path = dir + file_name

		var greeting = load(path) as Greeting

		greeting_pool.append(greeting)




