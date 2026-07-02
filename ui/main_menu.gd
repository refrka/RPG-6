class_name MainMenu extends GameScene


@onready var save_list_row_scene:= preload("res://ui/save_list_row.tscn")



@export var start_new_game_button: Button

@export var new_character_name_entry: LineEdit

@export var save_list: VBoxContainer




func _ready() -> void:

	super()

	start_new_game_button.pressed.connect(_on_start_new_game_pressed)

	Saves.save_list_updated.connect(_load_save_list)

	_load_save_list()

	visibility_changed.connect(_on_visibility_changed)







func _load_save_list() -> void:

	_clear_save_list()

	for save_data in Saves.current_saves:

		var row = save_list_row_scene.instantiate()
		
		row.save_name_button.text = save_data.save_name

		row.save_name_button.pressed.connect(_on_save_selected.bind(save_data))

		row.delete_button.pressed.connect(_on_delete_pressed.bind(save_data))

		save_list.add_child(row)





func _clear_save_list() -> void:

	for child in save_list.get_children():

		child.queue_free()






func _on_start_new_game_pressed() -> void:

	var character_name = new_character_name_entry.text

	if character_name == "":

		return

	Saves.create_save(character_name)

	new_character_name_entry.clear()




func _on_save_selected(save_data: SaveData) -> void:

	Game.start(save_data.save_id)



func _on_delete_pressed(save_data: SaveData) -> void:

	Saves.delete_save_data(save_data.save_id)





func _on_visibility_changed() -> void:

	new_character_name_entry.clear()