class_name ItemListRow extends PanelContainer


signal left_pressed

signal right_pressed

signal item_selected



@export var item_id_label: Label

@export var item_count_label: Label

@export var left_button: Button

@export var right_button: Button


var item_id: StringName

var count: int







func _ready() -> void:

	left_button.pressed.connect(left_pressed.emit)

	right_button.pressed.connect(right_pressed.emit)

	gui_input.connect(_on_gui_input)




func set_data(_item_id: StringName, _count: int) -> void:

	item_id = _item_id

	count = _count

	var item_def = Items.get_def(item_id)

	item_id_label.text = item_def.display_name

	item_count_label.text = str(count)





func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 2:

		item_selected.emit()
