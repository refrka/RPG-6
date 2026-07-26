class_name BarterPanel extends Overlay




@export var barter_title_label: Label

@export var close_button: Button

@export var player_inventory_display: InventoryDisplay

@export var entity_inventory_display: InventoryDisplay


var target_entity: EntityNode



func _ready() -> void:

	close_button.pressed.connect(_on_close_pressed)




func load_barter_inventories(_target_entity: EntityNode) -> void:

	target_entity = _target_entity

	entity_inventory_display.load_inventory(target_entity.inventory)

	var player = Game.get_player()

	player_inventory_display.load_inventory(player.inventory)






func clear() -> void:

	player_inventory_display.clear()

	entity_inventory_display.clear()






func _on_close_pressed() -> void:

	close_requested.emit(self)