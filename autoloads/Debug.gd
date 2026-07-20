extends Node




var debug_panel: DebugPanel







func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		debug_panel.toggle()
