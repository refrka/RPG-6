class_name DebugShitPanel extends Overlay




@export var item_def_list: ItemDefList

@export var item_count_entry: LineEdit

@export var add_item_button: Button

@export var remove_item_button: Button





func _ready() -> void:

	Debug.debug_shit_panel = self

	add_item_button.pressed.connect(_on_add_pressed)

	remove_item_button.pressed.connect(_on_remove_pressed)







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







