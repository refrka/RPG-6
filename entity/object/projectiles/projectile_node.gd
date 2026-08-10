class_name ProjectileNode extends ObjectNode


@export var screen_notifier: VisibleOnScreenNotifier2D

var projectile_def: EquipmentDef

var projectile_owner: EntityNode

var damage_package: DamagePackage





func _initialize() -> bool:

	if !super():

		return false

	screen_notifier.screen_exited.connect(_on_screen_exited)

	combat_hitbox.setup(self)

	var projectile_component = get_component(ProjectileComponent)

	projectile_component.expired.connect(_on_projectile_expired)

	projectile_component.hit_detected.connect(_on_projectile_hit_detected)

	return true





func _update_node() -> void:

	body_sprite.texture = projectile_def.icon_texture

	body_sprite.position.y = projectile_def.body_y_offset

	body_collision.shape = projectile_def.body_collision_shape

	body_collision.position = projectile_def.body_collision_position

	combat_hitbox.collision_shape.shape = projectile_def.hitbox_collision_shape

	combat_hitbox.collision_shape.position = projectile_def.hitbox_position







static func create_node(_projectile_def: ProjectileDef) -> ProjectileNode:

	var projectile_node = load("res://entity/object/projectiles/projectile_node.tscn").instantiate()

	projectile_node.projectile_def = _projectile_def

	projectile_node.entity_def = _projectile_def.projectile_object_def

	projectile_node._update_node()

	return projectile_node




func _on_screen_exited() -> void:

	removal_requested.emit()



func _on_projectile_hit_detected(target_entity: EntityNode) -> void:

	target_entity.accept_hit(damage_package)

	removal_requested.emit.call_deferred()
	



func _on_projectile_expired() -> void:

	removal_requested.emit()


