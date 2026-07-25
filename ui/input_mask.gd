class_name InputMask extends MarginContainer


signal hover_state_changed(state: bool)

signal gui_input_received(event: InputEvent)



var active:= true

var hovered:= false




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)




func _activate() -> void:

	active = true



func _deactivate() -> void:

	if hovered:

		_on_mouse_exited()

	active = false




func _on_mouse_entered() -> void:

	if active:

		hovered = true

		hover_state_changed.emit(true)




func _on_mouse_exited() -> void:

	if active:

		hovered = false

		hover_state_changed.emit(false)




func _on_gui_input(event: InputEvent) -> void:

	if active:

		gui_input_received.emit(event)

