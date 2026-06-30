class_name DialogueOption extends MarginContainer


signal selected


@export var option_button: Button






func _ready() -> void:

	option_button.pressed.connect(_on_option_selected)




func set_option_text(text: String) -> void:

	option_button.text = text




func _on_option_selected() -> void:

	selected.emit()