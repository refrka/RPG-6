class_name GamePopup extends Overlay



signal popup_completed

signal boolean_completed(response: bool)


enum PopupMode {

	CONTINUE,

	BOOLEAN,

	CONFIRM,

}


@export var title_label: Label

@export var title_section: VBoxContainer

@export var message_label: RichTextLabel

@export var continue_button: Button

@export var no_button: Button

@export var yes_button: Button

@export var boolean_section: HBoxContainer

@export var cancel_button: Button

@export var confirm_button: Button

@export var confirm_section: HBoxContainer





func _ready() -> void:

	continue_button.pressed.connect(_on_continue_pressed)

	no_button.pressed.connect(_on_boolean_selected.bind(false))

	yes_button.pressed.connect(_on_boolean_selected.bind(true))

	cancel_button.pressed.connect(_on_boolean_selected.bind(false))

	confirm_button.pressed.connect(_on_boolean_selected.bind(true))

	set_mode(PopupMode.CONTINUE)






func set_text(message: String, title:= "") -> void:

	message_label.text = message

	if title == "":

		title_section.hide()

	else:

		title_section.show()

		title_label.text = title


	

func set_mode(mode: PopupMode) -> void:

	match mode:

		PopupMode.CONTINUE:

			continue_button.show()

			boolean_section.hide()

			confirm_section.hide()

		PopupMode.BOOLEAN:

			continue_button.hide()

			boolean_section.show()

			confirm_section.hide()

		PopupMode.CONFIRM:

			continue_button.hide()

			boolean_section.hide()

			confirm_section.show()





func _on_continue_pressed() -> void:

	popup_completed.emit(self)



func _on_boolean_selected(state: bool) -> void:

	boolean_completed.emit(self, state)