class_name DebugMask extends InputMask



@export var panel: PanelContainer


var border_size: int: 

	set(value):

		border_size = value

		var stylebox = panel.get_theme_stylebox("panel").duplicate()

		stylebox.border_width_top = border_size

		stylebox.border_width_bottom = border_size

		stylebox.border_width_left = border_size

		stylebox.border_width_right = border_size

		panel.add_theme_stylebox_override("panel", stylebox)



var border_color_a: float:

	set(value):

		border_color_a = value

		var stylebox = panel.get_theme_stylebox("panel").duplicate()

		stylebox.border_color.a = border_color_a

		panel.add_theme_stylebox_override("panel", stylebox)




func _ready() -> void:

	super()

	Debug.mouse_activated.connect(_on_debug_mouse_activated)

	Debug.mouse_deactivated.connect(_on_debug_mouse_deactivated)








func _deactivate() -> void:

	super()









func _on_mouse_entered() -> void:

	if !Debug.mouse_active or !active:

		return

	super()

	border_color_a = 0.6






func _on_mouse_exited() -> void:

	super()

	border_color_a = 0.25


	




func _on_gui_input(event: InputEvent) -> void:

	if !Debug.mouse_active or !active:

		return

	super(event)

	get_viewport().set_input_as_handled()








func _on_debug_mouse_activated() -> void:

	if !active:

		_activate()


func _on_debug_mouse_deactivated() -> void:

	if active:

		_deactivate()