extends Node



var debug_shit_panel: DebugShitPanel












func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		debug_shit_panel.toggle()