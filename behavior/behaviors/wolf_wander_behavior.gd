class_name WolfWanderBehavior extends WanderBehavior




var combat_component: CombatComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_component = entity.get_component(CombatComponent)



func _start() -> void:
	
	super()

	combat_component.target_changed.connect(_on_combat_target_changed)



func _end() -> void:

	combat_component.target_changed.disconnect(_on_combat_target_changed)

	super()



func _on_combat_target_changed(target_entity: EntityNode) -> void:

	behavior_component.evaluate_and_choose({"target_entity": target_entity})