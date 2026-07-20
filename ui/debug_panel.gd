class_name DebugPanel extends Overlay







@export var item_id_entry: LineEdit

@export var add_to_player_inventory_button: Button






func _ready() -> void:

	item_id_entry.text_changed.connect(_on_item_id_text_changed)

	add_to_player_inventory_button.pressed.connect(_on_add_to_player_inventory_pressed)

	add_to_player_inventory_button.disabled = true




func _enter_tree() -> void:

	super()

	Debug.debug_panel = self





func _on_item_id_text_changed(text: String) -> void:

	if Items.get_item_def(text) == null:

		add_to_player_inventory_button.disabled = true

	else:

		add_to_player_inventory_button.disabled = false




func _on_add_to_player_inventory_pressed() -> void:

	var item_def = Items.get_item_def(item_id_entry.text)

	if !item_def:

		return

	var player = Game.get_player()

	if !player or !player.inventory:

		return

	var count_selector = UI.show_count_selector(0, 999)

	count_selector.count_submitted.connect(_on_add_count_submitted.bind(item_def))





func _on_add_count_submitted(count: int, item_def: ItemDef) -> void:

	var player = Game.get_player()

	player.inventory.add_item(item_def, count)