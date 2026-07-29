extends Node



var debug_shit_panel: DebugShitPanel






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		print("oprhans:")

		print_orphan_nodes()

		print("/orphans")

		debug_shit_panel.toggle()