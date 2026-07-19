class_name DialoguePanel extends Overlay


signal dialogue_advanced

signal dialogue_closed

signal option_selected(dialogue_node: DialogueNode)


@onready var dialogue_option_button_scene = preload("res://ui/dialogue_option_button.tscn")




@export var dialogue_section: MarginContainer

@export var option_section: MarginContainer

@export var option_list: VBoxContainer

@export var input_mask: InputMask



@export var dialogue_text_label: RichTextLabel




func _ready() -> void:

	input_mask.gui_input_received.connect(_on_gui_input_received)




func _deactivate() -> void:

	super()

	dialogue_closed.emit()




func set_text(text: String) -> void:

	dialogue_text_label.text = text





func set_options(options: Array[DialogueNode] = []) -> void:

	if options == []:

		option_section.visible = false

	else:

		option_section.visible = true

	_clear_options()

	for dialogue_node in options:

		var button = dialogue_option_button_scene.instantiate()
		
		button.text = dialogue_node.option_text

		button.pressed.connect(_on_option_selected.bind(dialogue_node))

		_add_option_button(button)










func _add_option_button(option_button: DialogueOptionButton) -> void:

	option_list.add_child(option_button)





func _clear_options() -> void:

	for child in option_list.get_children():

		child.queue_free()








func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		dialogue_advanced.emit()



func _on_option_selected(option_node: DialogueNode) -> void:

	option_selected.emit(option_node)