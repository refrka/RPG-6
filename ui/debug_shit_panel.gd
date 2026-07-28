class_name DebugShitPanel extends Overlay




@export var item_def_list: ItemDefList

@export var item_count_entry: LineEdit

@export var add_item_button: Button

@export var remove_item_button: Button

@export var location_id_list: OptionButton

@export var spawn_id_list: OptionButton

@export var move_button: Button




func _ready() -> void:

	Debug.debug_shit_panel = self

	add_item_button.pressed.connect(_on_add_pressed)

	remove_item_button.pressed.connect(_on_remove_pressed)

	location_id_list.item_selected.connect(_on_location_id_selected)

	location_id_list.select(0)

	location_id_list.item_selected.emit(0)

	location_id_list.get_popup().add_theme_constant_override("v_separation", 16)

	spawn_id_list.get_popup().add_theme_constant_override("v_separation", 16)

	move_button.pressed.connect(_on_move_pressed)








func _on_add_pressed() -> void:

	var item_id: String = item_def_list.get_item_metadata(item_def_list.selected)

	if item_id == "":

		return

	if !item_count_entry.text.is_valid_int():

		return

	var item_def = Items.get_item_def(item_id)

	if !item_def:

		return

	var count = int(item_count_entry.text)

	Game.get_player().inventory.add_items(item_def, count)

	



func _on_remove_pressed() -> void:

	var item_id: String = item_def_list.get_item_metadata(item_def_list.selected)

	if item_id == "":

		return

	if !item_count_entry.text.is_valid_int():

		return

	var item_def = Items.get_item_def(item_id)

	if !item_def:

		return

	var count = int(item_count_entry.text)

	Game.get_player().inventory.remove_items(item_def, count)






func _on_location_id_selected(index: int) -> void:

	spawn_id_list.clear()

	var location_id = location_id_list.get_item_text(index)

	var location = Scenes.get_location_scene(location_id) as Location

	var spawn_points = location.get_all_spawn_points()

	for spawn_point in spawn_points:

		spawn_id_list.add_item(spawn_point.spawn_id)

	location.free()




func _on_move_pressed() -> void:

	if !Game.is_active():

		return

	var location_id = location_id_list.get_item_text(location_id_list.selected)

	var spawn_id = spawn_id_list.get_item_text(spawn_id_list.selected)

	var active_location = Scenes.get_world_scene().get_active_location()

	var player = Game.get_player()

	if active_location.location_id == location_id:

		var spawn_point = active_location.get_spawn_point(spawn_id)

		player.reposition(spawn_point.global_position)

		player.active_spawn_point = spawn_point

	else:

		Game.hold_player_node()

		var world_scene = Scenes.get_world_scene()

		world_scene.active_location.remove_entity_node(player)

		var location = Scenes.load_location(location_id)

		location.spawn_entity_node(player, spawn_id)