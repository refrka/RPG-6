class_name GameMenu extends Overlay




@export var resume_button: Button

@export var exit_to_menu_button: Button

@export var quit_to_desktop_button: Button






func _ready() -> void:

	resume_button.pressed.connect(_on_resume_pressed)

	exit_to_menu_button.pressed.connect(_on_exit_to_menu_pressed)

	quit_to_desktop_button.pressed.connect(_on_quit_to_desktop_pressed)



func _on_resume_pressed() -> void:

	UI.remove_overlay(self)




func _on_exit_to_menu_pressed() -> void:

	Game.end()



func _on_quit_to_desktop_pressed() -> void:

	get_tree().quit()




