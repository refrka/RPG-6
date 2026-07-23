class_name InventoryItemRow extends PanelContainer






@export var item_name_label: Label

@export var button_list: HBoxContainer

@export var input_mask: InputMask



@export var default_stylebox: StyleBoxFlat

@export var hover_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat






func _ready() -> void:

	_connect_input_mask()






func _connect_input_mask() -> void:

	input_mask.hover_state_changed.connect(_on_hover_state_changed)

	input_mask.gui_input_received.connect(_on_gui_input_received)



func _disconnect_input_mask() -> void:

	input_mask.hover_state_changed.disconnect(_on_hover_state_changed)

	input_mask.gui_input_received.disconnect(_on_gui_input_received)




func _on_hover_state_changed(state: bool) -> void:

	if state == true:
		
		add_theme_stylebox_override("panel", hover_stylebox)

	else:

		add_theme_stylebox_override("panel", default_stylebox)





func _on_gui_input_received(event: InputEvent) -> void:

	pass







func _disable() -> void:

	pass




func _enable() -> void:

	pass