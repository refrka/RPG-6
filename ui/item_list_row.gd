class_name ItemListRow extends PanelContainer


signal left_pressed

signal right_pressed

signal item_selected



@export var item_id_label: Label

@export var item_count_label: Label

@export var left_button: Button

@export var right_button: Button


var item_data: NewItemData





func _ready() -> void:

	left_button.pressed.connect(left_pressed.emit)

	right_button.pressed.connect(right_pressed.emit)

	gui_input.connect(_on_gui_input)




func set_data(_item_data: NewItemData, count:= -1) -> void:

	item_data = _item_data

	var item_def = Items.get_item_def(item_data.get_item_id())

	item_id_label.text = item_def.display_name

	if count == -1:

		count = item_data.get_count()

	item_count_label.text = str(count)





func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 2:

		item_selected.emit()
