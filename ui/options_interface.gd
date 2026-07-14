class_name OptionsInterface extends MarginContainer



signal dialogue_option_selected(dialogue_node: DialogueNode)

signal next_line_pressed

signal branch_ended




@onready var dialouge_option_scene:= preload("res://ui/dialogue_option.tscn")

@export var options_list: VBoxContainer

@export var next_line_button: Button




var current_options: Array[DialogueNode]



func _ready() -> void:

	next_line_button.pressed.connect(_on_next_line_pressed)






func load_root_options(target_entity: EntityNode) -> void:

	hide_next_button()

	_clear_options()

	var root_options: Array[DialogueRootNode] = []

	var dialogue_library = target_entity.def.dialogue_library

	for dialogue_branch in dialogue_library.branches:

		if dialogue_branch.show_condition_set and !dialogue_branch.show_condition_set.evaluate():

			continue

		root_options.append(dialogue_branch.root_node)

	root_options.append_array(Quests.get_quest_dialogue_nodes(target_entity))

	for option in root_options:

		_add_option(option)

	




func show_next_button() -> void:

	next_line_button.visible = true



func hide_next_button() -> void:

	next_line_button.visible = false





func _load_dialogue_options(dialogue_node: DialogueNode) -> void:

	_clear_options()

	Events.fire(DialogueNodeEnteredEvent, {"dialogue_node": dialogue_node})

	if dialogue_node.option_nodes.is_empty():

		branch_ended.emit()

		return

	for option in dialogue_node.option_nodes:

		_add_option(option)








	


func _clear_options() -> void:

	for child in options_list.get_children():

		child.queue_free()






func _add_option(dialogue_node: DialogueNode) -> void:

	current_options.append(dialogue_node)

	var option = dialouge_option_scene.instantiate()

	option.set_option_text(dialogue_node.option_text)

	option.selected.connect(_on_option_selected.bind(dialogue_node))

	options_list.add_child(option)







func _on_option_selected(dialogue_node: DialogueNode) -> void:

	dialogue_option_selected.emit(dialogue_node)

	_load_dialogue_options(dialogue_node)





func _on_next_line_pressed() -> void:

	next_line_pressed.emit()