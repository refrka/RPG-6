extends Node



signal dialogue_finished



var dialogue_panel: DialoguePanel:

	get:

		if !dialogue_panel:

			dialogue_panel = UI.get_overlay(DialoguePanel)

		return dialogue_panel


var current_dialogue_source: EntityNode

var current_dialogue_node: DialogueNode

var current_dialogue_text: DialogueText

var current_options: Array[DialogueNode]


var line_index:= 0



func _ready() -> void:

	dialogue_panel.dialogue_advanced.connect(_on_dialogue_advanced)

	dialogue_panel.option_selected.connect(_on_option_selected)





func start_dialogue(greeting: Greeting, root_nodes: Array[DialogueNode] = []) -> void:

	line_index = 0

	dialogue_panel.set_text(greeting.dialogue_lines.front())

	current_options.assign(root_nodes)

	dialogue_panel.set_options(current_options)

	dialogue_panel._activate()







func load_dialogue_node(dialogue_node: DialogueNode) -> void:

	dialogue_panel._activate()

	line_index = 0

	if current_dialogue_node:

		current_dialogue_node._exit()

	current_dialogue_node = dialogue_node

	current_dialogue_text = current_dialogue_node.dialogue_text

	current_options.clear()

	for option_node in current_dialogue_node.options:

		if option_node.show_condition_set and !option_node.show_condition_set.evaluate():

			continue
		
		current_options.append(option_node)

	dialogue_panel.set_options(current_options)

	current_dialogue_node._enter()

	update_dialogue_line()




func load_dialogue_text(dialogue_text: DialogueText) -> void:

	dialogue_panel._activate()

	current_dialogue_text = dialogue_text

	line_index = 0

	update_dialogue_line()

	dialogue_panel.set_options()




func update_dialogue_line() -> void:

	if !current_dialogue_text or current_dialogue_text.dialogue_lines.size() - 1 < line_index:

		return

	var line = get_dialogue_line(line_index)

	dialogue_panel.set_text(line)





func get_greeting(entity_node: EntityNode, root_nodes: Array[DialogueNode] = []) -> Greeting:

	return entity_node.get_def().dialogue_library.greetings.front()





func get_root_nodes(entity_node: EntityNode) -> Array[DialogueNode]:

	var root_nodes: Array[DialogueNode] = []

	var def = entity_node.get_def()

	if def.dialogue_library:

		root_nodes.append_array(def.dialogue_library.dialogue_nodes)

	return root_nodes




func get_dialogue_panel() -> DialoguePanel:

	return UI.get_overlay(DialoguePanel)




func get_dialogue_line(index: int) -> String:

	return current_dialogue_text.dialogue_lines[index]





func _on_dialogue_advanced() -> void:

	line_index += 1

	if !current_dialogue_text or line_index > current_dialogue_text.dialogue_lines.size() - 1:

		if current_options.is_empty():

			dialogue_panel._deactivate()

			dialogue_finished.emit()

	else:

		update_dialogue_line()




func _on_option_selected(dialogue_node: DialogueNode) -> void:

	load_dialogue_node(dialogue_node)