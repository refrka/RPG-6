class_name CombatState extends State




var movement_component: MovementComponent

var combat_component: CombatComponent





func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	combat_component = entity.get_component(CombatComponent)




func _enter() -> void:

	super()

	if animation_component.get_playback_node("root") != "CombatState":

		animation_component.travel_playback("root", "CombatState")
