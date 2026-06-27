extends Node




var active:= false


var debug_overlay: DebugOverlay




func _ready() -> void:

	debug_overlay = get_tree().get_first_node_in_group("debug_overlay")

	_deactivate()








func _activate() -> void:

	active = true

	debug_overlay._activate()




func _deactivate() -> void:

	active = false

	debug_overlay._deactivate()





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		if active:

			_deactivate()

		else:

			_activate()