class_name CombatAttackingState extends CombatState



var attack_animation_node: AnimationNodeAnimation






func _enter() -> void:

	super()

	var attack_dir = combat_component.current_attack_dir

	movement_component.set_face_dir(attack_dir)

	animation_component.set_blend_space_vector("attack", attack_dir)

	animation_component.set_blend_space_vector("end_attack", attack_dir)

	combat_playback.travel("CombatAttackState")


