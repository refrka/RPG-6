class_name DialoguePanel extends MarginContainer



signal close_requested




@export var dialogue_section: MarginContainer

@export var entity_name_label: Label

@export var dialogue_label: RichTextLabel

@export var option_section: MarginContainer

@export var option_list: VBoxContainer

@export var barter_button: Button

@export var close_button: Button





var current_node: DialogueNode

var current_options: Array[DialogueNode]








func _ready() -> void:

	close_button.pressed.connect(_on_close_pressed)





func load_root_options(target_entity: EntityNode) -> Array[DialogueRootNode]:

	var root_options: Array[DialogueRootNode] = []

	var dialogue_library = target_entity.def.dialogue_library

	if !dialogue_library:

		return []

	for dialogue_branch in dialogue_library.branches:

		if dialogue_branch.show_condition_set and dialogue_branch.show_condition_set.evaluate():

			root_options.append(dialogue_branch.root_node)

	for option in root_options:

		_add_option(option)

	return root_options






func _add_option(dialogue_node: DialogueNode) -> void:

	current_options.append(dialogue_node)

	var button = Button.new()

	button.text = dialogue_node.option_text

	option_list.add_child(button)




func _clear_options() -> void:

	for option_button in option_list.get_children():

		option_button.queue_free()

	current_options.clear()


















func _on_close_pressed() -> void:

	close_requested.emit()