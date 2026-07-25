class_name DialoguePanel extends Overlay



signal panel_closed

signal option_selected



@onready var option_button_scene:= preload("res://ui/dialogue_option_button.tscn")



@export var source_section: MarginContainer

@export var dialogue_section: MarginContainer

@export var response_section: MarginContainer



@export var source_name_label: Label

@export var dialogue_text_label: RichTextLabel

@export var option_list: VBoxContainer

@export var close_button: Button

@export var next_arrow: Label

@export var input_mask: InputMask



var current_source: EntityNode

var current_dialogue_text: DialogueText

var current_options: Array[DialogueNode]



var line_index:= -1



func _ready() -> void:

	close_button.pressed.connect(_on_close_pressed)

	input_mask.gui_input_received.connect(_on_gui_input_received)

	Dialogue.dialogue_panel = self






func set_dialogue(source: EntityNode, dialogue_text: DialogueText, options: Array[DialogueNode]) -> void:

	line_index = -1

	current_source = source

	current_dialogue_text = dialogue_text

	current_options = options

	_show_current_options()

	_show_next_line()





func _show_next_line() -> void:

	line_index += 1

	if !_is_index_valid(line_index):

		return

	var line = current_dialogue_text.lines[line_index]

	dialogue_text_label.text = line

	var next_index = line_index + 1

	if _is_index_valid(next_index):

		next_arrow.visible = true

	else:

		next_arrow.visible = false





func _show_current_options() -> void:

	_clear_options()

	if current_options.is_empty():

		response_section.hide()

	else:

		response_section.show()

	for dialogue_node in current_options:

		var button = option_button_scene.instantiate()

		button.text = dialogue_node.option_text

		button.pressed.connect(_on_option_selected.bind(dialogue_node))

		option_list.add_child(button)




func _close_dialogue() -> void:

	line_index = -1

	current_dialogue_text = null

	current_source = null

	current_options.clear()

	panel_closed.emit()


	

func _clear_options() -> void:

	for option in option_list.get_children():

		option.queue_free()




func _on_option_selected(option: DialogueNode) -> void:

	option_selected.emit(option)




func _is_index_valid(index: int) -> bool:

	if !current_dialogue_text:

		return false

	return index <= current_dialogue_text.lines.size() - 1





func _deactivate() -> void:

	super()

	if current_source:

		_close_dialogue()




func _on_close_pressed() -> void:

	_close_dialogue()





func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		_show_next_line()