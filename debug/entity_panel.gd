class_name EntityPanel extends MarginContainer




@export var type_list: OptionButton

@export var entity_list: OptionButton

@export var show_button: Button

@export var local_check_box: CheckBox

@export var entity_display: EntityDisplay





var selected_type: int

var types = ["data", "def"]




func _ready() -> void:

	show_button.pressed.connect(_on_show_pressed)

	type_list.item_selected.connect(_on_type_selected)

	local_check_box.toggled.connect(_on_local_toggled)






func refresh() -> void:

	match types[type_list.selected]:

		"data":

			_load_entity_data()

		"def":

			_load_entity_defs()






func _clear_entity_list() -> void:

	entity_list.clear()





func _load_entity_data(location_id:="") -> void:

	_clear_entity_list()

	var save_data = Game.get_save_data()

	if !save_data:

		return

	var data_list = save_data.entity_data_list

	for entity_data in data_list:

		if location_id != "" and entity_data.last_known_location_id != location_id:

			continue

		entity_list.add_item(entity_data.def.unique_id)




func _load_entity_defs() -> void:

	_clear_entity_list()

	for entity_id in Entities.def_registry:

		entity_list.add_item(entity_id)






func _on_show_pressed() -> void:

	match types[type_list.selected]:

		"data":

			var save_data = Game.get_save_data()

			var entity_data = save_data.entity_data_list[entity_list.selected]

			entity_display.display_entity_data(entity_data)

		"def":

			var entity_id = entity_list.get_item_text(entity_list.selected)

			var entity_def = Entities.get_def(entity_id)

			entity_display.display_entity_def(entity_def)




func _on_type_selected(index: int) -> void:

	if index == selected_type:

		return

	selected_type = index

	match types[index]:

		"data":

			local_check_box.disabled = false

			_load_entity_data()

		"def":

			local_check_box.disabled = true

			_load_entity_defs()






func _on_local_toggled(state: bool) -> void:

	if state == true:

		var location_scene = Scenes.get_scene(LocationScene)

		_load_entity_data(location_scene.location_id)

	else:

		_load_entity_data()