class_name DialoguePanel extends UIOverlay



signal close_requested




@onready var dialouge_option_scene:= preload("res://ui/dialogue_option.tscn")

@export var dialogue_section: MarginContainer

@export var entity_name_label: Label

@export var dialogue_label: RichTextLabel

@export var option_section: MarginContainer

@export var option_list: VBoxContainer

@export var barter_section: MarginContainer

@export var player_item_list: VBoxContainer

@export var entity_item_list: VBoxContainer

@export var sell_list: VBoxContainer

@export var buy_list: VBoxContainer

@export var barter_button: Button

@export var dialogue_button: Button

@export var close_button: Button



var current_entity: EntityNode

var current_node: DialogueNode

var current_options: Array[DialogueNode]

var current_section: MarginContainer






func _ready() -> void:

	barter_button.pressed.connect(_on_barter_pressed)

	close_button.pressed.connect(_on_close_pressed)







func load_dialogue(target_entity: EntityNode) -> void:

	_activate()

	current_section = option_section

	_load_entity(target_entity)

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






func load_barter(target_entity: EntityNode) -> void:

	current_section = barter_section

	if current_entity != target_entity:

		_load_entity(target_entity)







func toggle() -> void:

	if active: 

		_deactivate()

		close_requested.emit()

	else:

		_activate()





func _enter_dialogue_node(dialogue_node: DialogueNode) -> void:

	if dialogue_node is QuestDialogueNode:

		if Quests.get_quest_state(dialogue_node.quest_id) == QuestData.QuestState.AVAILABLE:

			Quests.set_quest_state(dialogue_node.quest_id, QuestData.QuestState.ACTIVE)

	if dialogue_node.enter_command_set:

		var data = {}

		if dialogue_node is QuestDialogueNode:

			data["quest_id"] = dialogue_node.quest_id

		dialogue_node.enter_command_set.execute(data)

	Events.fire(DialogueNodeEnteredEvent, {"dialogue_node": dialogue_node})

	_clear_options()

	for option in dialogue_node.option_nodes:

		_add_option(option)





func _exit_dialogue_node(dialogue_node: DialogueNode) -> void:

	Events.fire(DialogueNodeExitedEvent, {"dialogue_node": dialogue_node})








func _load_entity(entity_node: EntityNode) -> void:

	current_entity = entity_node

	entity_name_label.text = entity_node.get_display_name()






func _add_option(dialogue_node: DialogueNode) -> void:

	current_options.append(dialogue_node)

	var option = dialouge_option_scene.instantiate()

	option.set_option_text(dialogue_node.option_text)

	option.selected.connect(_on_option_selected.bind(dialogue_node))

	option_list.add_child(option)




func _clear_options() -> void:

	for option_button in option_list.get_children():

		option_button.queue_free()

	current_options.clear()



func _clear_barter() -> void:

	pass














func _on_close_pressed() -> void:

	close_requested.emit()



func _on_barter_pressed() -> void:

	pass


func _on_option_selected(option_node: DialogueNode) -> void:

	_enter_dialogue_node(option_node)