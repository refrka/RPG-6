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

var barter_component: InteractableComponent

var dialogue_component: DialogueComponent








func _ready() -> void:

	close_button.pressed.connect(_on_close_pressed)






func load_interaction(target_entity: EntityNode) -> void:

	current_entity = target_entity

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




func _load_barter_interface() -> void:

	pass











func _on_close_pressed() -> void:

	close_requested.emit()