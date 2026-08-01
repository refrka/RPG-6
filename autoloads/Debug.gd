extends Node


signal mouse_activated

signal mouse_deactivated

signal debug_mask_selected

signal debug_mask_deselected



var debug_shit_panel: DebugShitPanel

var mouse_active:= false



var selected_debug_mask: DebugMask




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_deactivate_debug_mouse()




func select_debug_mask(debug_mask: DebugMask) -> void:

	if selected_debug_mask:

		deselect_debug_mask()

	selected_debug_mask = debug_mask

	selected_debug_mask.select()

	debug_mask_selected.emit(debug_mask)

	


func deselect_debug_mask() -> void:

	selected_debug_mask.deselect()

	selected_debug_mask = null

	debug_mask_deselected.emit()







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