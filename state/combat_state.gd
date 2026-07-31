class_name CombatState extends State


var combat_playback: AnimationNodeStateMachinePlayback


func _enter() -> void:

	if root_playback.get_current_node() != "CombatState":

		root_playback.travel("CombatState")

	combat_playback = animation_component.get_state_playback("combat")
