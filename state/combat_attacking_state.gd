class_name CombatAttackingState extends CombatState



var attack_animation_node: AnimationNodeAnimation






func _enter() -> void:

	super()

	combat_playback.travel("CombatAttackState")


