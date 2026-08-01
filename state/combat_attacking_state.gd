class_name CombatAttackingState extends CombatState



var attack_animation_node: AnimationNodeAnimation






func _enter() -> void:

	super()

	var attack_dir = combat_component.current_attack_dir

	movement_component.set_face_dir(attack_dir)

	animation_component.set_blend_space_vector("attack", attack_dir)

	animation_component.set_blend_space_vector("end_attack", attack_dir)

	animation_component.travel_playback("combat", "CombatAttackState")

	var move_speed = entity.get_entity_def().move_speed

	movement_component.set_move_speed_override(move_speed * (1.0 - combat_component._get_attack_entry().move_penalty))




func _exit() -> void:

	super()

	movement_component.remove_move_speed_override()

