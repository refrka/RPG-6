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

		return false

	target_entity = _data["target_entity"]

	return true






func _start() -> void:

	navigation_component.target_pos_reached.connect(_on_target_pos_reached)

	navigation_component.set_target_entity(target_entity)




func _on_target_pos_reached() -> void:

	combat_component.attack()