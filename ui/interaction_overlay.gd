class_name InteractionOverlay extends UIOverlay



signal close_requested




@export var options_interface: OptionsInterface

@export var barter_interface: BarterInterface





@export var dialogue_button: Button

@export var barter_button: Button

@export var close_button: Button





@export var entity_name_label: Label

@export var dialogue_text_label: RichTextLabel






var current_entity: EntityNode

var current_dialogue_node: DialogueNode

var barter_component: InteractableComponent

var dialogue_component: DialogueComponent








func _ready() -> void:

	barter_button.pressed.connect(_load_barter_interface)

	dialogue_button.pressed.connect(_load_options_interface)

	close_button.pressed.connect(_on_close_pressed)

	options_interface.dialogue_option_selected.connect(_on_dialogue_option_selected)

	options_interface.branch_ended.connect(_on_branch_ended)






func load_interaction(target_entity: EntityNode) -> void:

	current_entity = target_entity

	entity_name_label.text = current_entity.get_display_name()

	barter_component = target_entity.get_component("barter")

	dialogue_component = target_entity.get_component("dialogue")

	if dialogue_component:

		_load_options_interface()

	else:

		_load_barter_interface()

	_activate()























func _load_options_interface() -> void:

	barter_interface.visible = false

	options_interface.visible = true

	barter_button.visible = true

	dialogue_button.visible = false

	options_interface.load_root_options(current_entity)











func _load_barter_interface() -> void:

	barter_interface.visible = true

	options_interface.visible = false

	barter_button.visible = false

	dialogue_button.visible = true

	barter_interface.load_inventory(barter_component.inventory)





func _deactivate() -> void:

	super()

	close_requested.emit()




func _on_close_pressed() -> void:

	close_requested.emit()




func _on_dialogue_option_selected(dialogue_node: DialogueNode) -> void:

	if current_dialogue_node:

		if current_dialogue_node.exit_command_set:

			current_dialogue_node.exit_command_set.execute({"dialogue_node": dialogue_node})

	current_dialogue_node = dialogue_node

	dialogue_text_label.text = current_dialogue_node.dialogue_text

	if current_dialogue_node.enter_command_set:

		current_dialogue_node.enter_command_set.execute({"dialogue_node": dialogue_node})





func _on_branch_ended() -> void:

	options_interface.load_root_options(current_entity)