class_name CombatState extends State


var combat_playback: AnimationNodeStateMachinePlayback


var movement_component: MovementComponent

var combat_component: CombatComponent





func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	combat_component = entity.get_component(CombatComponent)

	combat_playback = animation_component.get_state_playback("combat")




func _enter() -> void:

	if root_playback.get_current_node() != "CombatState":

		root_playback.travel("CombatState")
