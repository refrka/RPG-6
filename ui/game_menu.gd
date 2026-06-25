class_name GameMenu extends UIOverlay





@export var save_button: Button

@export var return_to_menu_button: Button

@export var quit_button: Button






func _ready() -> void:

	super()

	_deactivate()

	save_button.pressed.connect(_on_save_pressed)

	return_to_menu_button.pressed.connect(_on_return_to_menu_pressed)

	quit_button.pressed.connect(_on_quit_pressed)







func _on_save_pressed() -> void:

	Game.save()



func _on_return_to_menu_pressed() -> void:

	Game.exit()



func _on_quit_pressed() -> void:

	Game.save()

	get_tree().quit()