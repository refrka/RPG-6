class_name InventoryItemRow extends PanelContainer


signal row_selected(row: InventoryItemRow)

signal use_requested(row: InventoryItemRow)

signal discard_requested(row: InventoryItemRow)

signal row_seen(row: InventoryItemRow)



@export var item_name_label: Label

@export var description_label: Label

@export var item_count_label: Label

@export var button_list: HBoxContainer

@export var input_mask: InputMask

@export var info_section: MarginContainer

@export var use_button: Button

@export var discard_button: Button



@export var default_stylebox: StyleBoxFlat

@export var hover_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat



var item_data: ItemData


var selected:= false

var hovered:= false

var seen:= true



func _ready() -> void:

	_connect_input_mask()

	_hide_buttons()

	info_section.hide()

	use_button.pressed.connect(_on_use_pressed)

	discard_button.pressed.connect(_on_discard_pressed)






func load_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	description_label.text = item_data.get_description()

	_update_name_label()

	_update_count_label()

	item_data.count_updated.connect(_on_count_updated)






func select() -> void:

	selected = true

	info_section.show()

	add_theme_stylebox_override("panel", selected_stylebox)




func deselect() -> void:

	selected = false

	info_section.hide()

	add_theme_stylebox_override("panel", default_stylebox)

	_hide_buttons()

	if hovered:

		_on_hover_state_changed(true)






func sleep() -> void:

	# item_data.count_updated.disconnect(_on_count_updated)

	pass



func wake() -> void:

	# item_data.count_updated.connect(_on_count_updated)

	pass




func set_seen_state(state: bool) -> void:

	seen = state

	_update_name_label()

	if state == true:

		row_seen.emit(self)





func _update_name_label() -> void:

	var display_name = item_data.get_display_name()

	if !seen:

		display_name += " (new) "

	item_name_label.text = display_name





func _update_count_label() -> void:

	var count = item_data.get_count()

	if count > 1:

		item_count_label.text = "(%s)" % item_data.get_count()

	else:

		item_count_label.text = ""

	



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

		if !seen:

			set_seen_state(true)

		_show_buttons()
		
		add_theme_stylebox_override("panel", hover_stylebox)

	else:

		_hide_buttons()

		add_theme_stylebox_override("panel", default_stylebox)





func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and !selected:

		row_selected.emit(self)




func _on_count_updated(_item_data: ItemData, _amount: int, _added: bool) -> void:

	_update_count_label()



func _on_use_pressed() -> void:

	use_requested.emit(self)



func _on_discard_pressed() -> void:

	discard_requested.emit(self)





func _disable() -> void:

	pass




func _enable() -> void:

	pass





