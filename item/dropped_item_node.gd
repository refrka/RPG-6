class_name DroppedItemNode extends StaticBody2D



@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D


var item_data: ItemData






func load_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	_update_node()











func _update_node() -> void:

	var item_def = item_data.get_item_def()

	body_sprite.texture = item_def.icon_texture

	body_sprite.position.y = item_def.icon_y_pos