class_name CombatChargingState extends CombatState



var attack_entry: AttackEntry



func _enter() -> void:

	super()

	var attack_dir = combat_component.current_attack_dir

	movement_component.set_face_dir(attack_dir)

	animation_component.travel_playback("combat", "CombatChargeState")

	animation_component.anim_tree.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

	attack_entry = combat_component._get_attack_entry()

	if !attack_entry.can_aim_charge:

		movement_component.can_turn = false





func _exit() -> void:

	super()

	movement_component.can_turn = true

	if animation_component.anim_tree.animation_finished.is_connected(_on_animation_finished):

		animation_component.anim_tree.animation_finished.disconnect(_on_animation_finished)




func _on_animation_finished(_anim_name: StringName) -> void:

	combat_component._complete_charge()






func _tick(_delta: float) -> void:

	if attack_entry.can_aim_charge:

		combat_component.set_attack_dir()