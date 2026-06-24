class_name MainMenu extends GameScene






@export var start_new_game_button: Button

@export var new_character_name_entry: LineEdit




func _ready() -> void:

	super()

	start_new_game_button.pressed.connect(_on_start_new_game_pressed)












func _on_start_new_game_pressed() -> void:

	var character_name = new_character_name_entry.text

	if character_name == "":

		return