class_name DroppedItemNode extends StaticBody2D


signal picked_up


@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var pick_up_sensor: Sensor


var item_data: ItemData






func _ready() -> void:

	pick_up_sensor.setup()

	pick_up_sensor.body_entered.connect(_on_body_entered_pick_up_sensor)




func load_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	_update_node()




func pick_up() -> void:

	var player = Game.get_player()

	player.inventory.add_data(item_data)

	picked_up.emit()





func _update_node() -> void:

	var item_def = item_data.get_item_def()

	body_sprite.texture = item_def.icon_texture

	body_sprite.position.y = item_def.body_y_offset




func _on_body_entered_pick_up_sensor(_body: PhysicsBody2D) -> void:

	pick_up()