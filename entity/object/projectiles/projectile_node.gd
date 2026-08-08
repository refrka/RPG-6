class_name ProjectileNode extends ObjectNode


@export var screen_notifier: VisibleOnScreenNotifier2D

var projectile_def: EquipmentDef




func _initialize() -> bool:

	if !super():

		return false

	screen_notifier.screen_exited.connect(_on_screen_exited)

	return true





func _update_node() -> void:

	body_sprite.texture = projectile_def.icon_texture

	body_sprite.position.y = projectile_def.icon_y_offset




static func create_node(_projectile_def: ProjectileDef) -> ProjectileNode:

	var projectile_node = load("res://entity/object/projectiles/projectile_node.tscn").instantiate()

	projectile_node.projectile_def = _projectile_def

	projectile_node.entity_def = _projectile_def.projectile_object_def

	projectile_node._update_node()

	return projectile_node




func _on_screen_exited() -> void:

	removal_requested.emit()