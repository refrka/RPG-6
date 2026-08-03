class_name WolfAttackBehavior extends Behavior



var navigation_component: NavigationComponent

var combat_component: CombatComponent

var target_entity: EntityNode



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	navigation_component = entity.get_component(NavigationComponent)

	combat_component = entity.get_component(CombatComponent)







func _evaluate(_data:= {}) -> bool:

	if !_data.has("target_entity"):

		print("no target, returning false")

		return false

	target_entity = _data["target_entity"]

	return true






func _start() -> void:

	navigation_component.target_pos_reached.connect(_on_target_pos_reached)

	combat_component.attack_finished.connect(_on_attack_finished)

	navigation_component.set_target_entity(target_entity)

	navigation_component.set_target_desired_distance(30.0)




func _end() -> void:

	navigation_component.target_pos_reached.disconnect(_on_target_pos_reached)

	combat_component.attack_finished.disconnect(_on_attack_finished)









func _is_target_in_range() -> bool:

	if !target_entity:

		return false

	return entity.global_position.distance_to(target_entity.global_position) <= 64.0









func _on_target_pos_reached() -> void:

	combat_component.attack()





func _on_attack_finished() -> void:

	if _is_target_in_range():

		combat_component.attack()