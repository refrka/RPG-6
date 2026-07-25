class_name InventoryItemRow extends PanelContainer


signal row_selected(row: InventoryItemRow)



@export var item_name_label: Label

@export var button_list: HBoxContainer

@export var input_mask: InputMask



@export var default_stylebox: StyleBoxFlat

@export var hover_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat



var item_data: ItemData


var selected:= false

var hovered:= false




func _ready() -> void:

	_connect_input_mask()







func load_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	item_name_label.text = item_data.get_display_name()




func select() -> void:

	selected = true

	add_theme_stylebox_override("panel", selected_stylebox)



func deselect() -> void:

	selected = false

	add_theme_stylebox_override("panel", default_stylebox)

	if hovered:

		_on_hover_state_changed(true)




func _show_buttons() -> void:

	button_list.show()


func _hide_buttons() -> void:

	button_list.hide()




func _connect_input_mask() -> void:

	input_mask.hover_state_changed.connect(_on_hover_state_changed)

	input_mask.gui_input_received.connect(_on_gui_input_received)



func _disconnect_input_mask() -> void:

	input_mask.hover_state_changed.disconnect(_on_hover_state_changed)

	input_mask.gui_input_received.disconnect(_on_gui_input_received)




func _on_hover_state_changed(state: bool) -> void:

	hovered = state

	if selected:

		return

	if state == true:

		_show_buttons()
		
		add_theme_stylebox_override("panel", hover_stylebox)

	else:

		_hide_buttons()

		add_theme_stylebox_override("panel", default_stylebox)





func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and !selected:

		row_selected.emit(self)







func _disable() -> void:

	pass




func _enable() -> void:

	pass