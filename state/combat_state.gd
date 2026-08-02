class_name CombatState extends State




var movement_component: MovementComponent

var combat_component: CombatComponent





func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	combat_component = entity.get_component(CombatComponent)

	var navigation_component = entity.get_component(NavigationComponent)

	if navigation_component:

		navigation_component.target_pos_updated.connect(_on_target_pos_updated)




func _enter() -> void:

	if animation_component.get_playback_node("root") != "CombatState":

		animation_component.travel_playback("root", "CombatState")

	super()




func _on_target_pos_updated() -> void:

	animation_component.set_blend_space_vector("ready_move", movement_component.face_dir)

	animation_component.set_blend_space_vector("ready_idle", movement_component.face_dir)

	animation_component.set_blend_space_vector("attack_move", movement_component.face_dir)

	animation_component.set_blend_space_vector("attack_idle", movement_component.face_dir)