class_name DebugPanel extends Overlay







@export var item_id_entry: LineEdit

@export var add_to_player_inventory_button: Button

@export var remove_from_player_inventory_button: Button





func _ready() -> void:

	item_id_entry.text_changed.connect(_on_item_id_text_changed)

	add_to_player_inventory_button.pressed.connect(_on_add_to_player_inventory_pressed)

	remove_from_player_inventory_button.pressed.connect(_on_remove_from_player_inventory_pressed)

	add_to_player_inventory_button.disabled = true

	remove_from_player_inventory_button.disabled = true




func _enter_tree() -> void:

	super()

	Debug.debug_panel = self





func _on_item_id_text_changed(text: String) -> void:

	var item_def = Items.get_item_def(text)

	if item_def == null:

		add_to_player_inventory_button.disabled = true

		remove_from_player_inventory_button.disabled = true

		return

	else:

		add_to_player_inventory_button.disabled = false

	var player = Game.get_player()

	if player.inventory and player.inventory.has_item(item_def):

		remove_from_player_inventory_button.disabled = false



func _on_add_to_player_inventory_pressed() -> void:

	var item_def = Items.get_item_def(item_id_entry.text)

	if !item_def:

		return

	var player = Game.get_player()

	if !player or !player.inventory:

		return

	var count_selector = UI.show_count_selector(1, 999)

	count_selector.count_submitted.connect(_on_add_count_submitted.bind(item_def))




func _on_remove_from_player_inventory_pressed() -> void:

	var item_def = Items.get_item_def(item_id_entry.text)

	var player = Game.get_player()

	if !item_def or !player or !player.inventory:

		return

	var item_data = player.inventory.get_item_data_from_def(item_def)

	var count_selector = UI.show_count_selector(1, item_data.get_count())

	count_selector.count_submitted.connect(_on_remove_count_submitted.bind(item_def))






func _on_add_count_submitted(count: int, item_def: ItemDef) -> void:

	var player = Game.get_player()

	player.inventory.add_item(item_def, count)




func _on_remove_count_submitted(count: int, item_def: ItemDef) -> void:

	var player = Game.get_player()

	player.inventory.remove_item(item_def, count)