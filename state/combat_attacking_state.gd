
class_name CombatAttackingState extends CombatState


var attack_animation_node: AnimationNodeAnimation






func _enter() -> void:

	super()

	var attack_dir = combat_component.current_attack_dir

	movement_component.set_face_dir(attack_dir)

	animation_component.travel_playback("combat", "CombatAttackState")

	var move_penalty = combat_component._get_attack_entry().move_penalty

	if move_penalty < 1.0 and movement_component.is_moving():

		animation_component.travel_playback("attack", "MoveBlend")

	movement_component.move_started.connect(_on_move_started)

	movement_component.move_stopped.connect(_on_move_stopped)




func _exit() -> void:

	super()

	movement_component.move_started.disconnect(_on_move_started)

	movement_component.move_stopped.disconnect(_on_move_stopped)




func _on_move_started() -> void:

	animation_component.travel_playback("attack", "MoveBlend")



func _on_move_stopped() -> void:

	animation_component.travel_playback("attack", "IdleBlend")