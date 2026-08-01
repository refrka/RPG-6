extends Node


signal mouse_activated

signal mouse_deactivated



var debug_shit_panel: DebugShitPanel

var mouse_active:= false



var selected_input_mask: CharacterDebugMask




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




func _activate_debug_mouse() -> void:

	mouse_active = true

	mouse_activated.emit()



func _deactivate_debug_mouse() -> void:

	mouse_active = false
	
	mouse_deactivated.emit()





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		debug_shit_panel.toggle()

	if event.is_action_pressed("mouse_debug"):

		_activate_debug_mouse()

	if event.is_action_released("mouse_debug"):

		_deactivate_debug_mouse()