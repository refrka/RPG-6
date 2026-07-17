class_name DialoguePanel extends Overlay




@export var dialogue_section: MarginContainer

@export var option_section: MarginContainer

@export var option_list: VBoxContainer



@export var dialogue_text_label: RichTextLabel











func _add_option_button(option_button: DialogueOptionButton) -> void:

	option_list.add_child(option_button)





func _clear_options() -> void:

	for child in option_list.get_children():

		child.queue_free()