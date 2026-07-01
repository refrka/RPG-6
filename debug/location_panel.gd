class_name LocationPanel extends DebugPanel



@export var location_list: OptionButton

@export var show_current_button: Button

@export var show_button: Button

@export var location_id_label: Label

var location_data: LocationData





func _ready() -> void:

	show_current_button.pressed.connect(_on_show_current_pressed)

	show_button.pressed.connect(_on_show_pressed)






func refresh() -> void:

	_load_location_list()




func display_location_data(_location_data: LocationData) -> void:

	location_data = _location_data

	location_id_label.text = location_data.location_id



func _load_location_list() -> void:

	location_list.clear()

	var save_data = Game.get_save_data()

	if save_data:

		for data in save_data.location_data_list:

			location_list.add_item(data.location_id)






func _on_show_current_pressed() -> void:

	var location_scene = Scenes.get_scene(LocationScene)

	if location_scene:

		var _location_data = Game.get_location_data(location_scene.location_id)

		display_location_data(_location_data)




func _on_show_pressed() -> void:

	if location_list.selected == -1:

		return

	var location_id = location_list.get_item_text(location_list.selected)

	var _location_data = Game.get_location_data(location_id)

	display_location_data(_location_data)