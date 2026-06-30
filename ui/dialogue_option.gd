class_name DialogueOption extends MarginContainer


signal selected


@export var option_button: Button






func _ready() -> void:

	option_button.pressed.connect(_on_option_selected)






func _on_option_selected() -> void:

	selected.emit()