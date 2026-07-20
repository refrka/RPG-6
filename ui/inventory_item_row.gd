class_name InventoryItemRow extends HBoxContainer



signal info_requested(row: InventoryItemRow)

signal discard_requested(row: InventoryItemRow)






@export var info_button: Button

@export var discard_button: Button

@export var item_name_label: Label

@export var button_list: HBoxContainer


var item_data: ItemData



func _ready() -> void:

	if !item_data:

		set_row_data(null)

	info_button.pressed.connect(info_requested.emit.bind(self))

	discard_button.pressed.connect(discard_requested.emit.bind(self))





func set_row_data(_item_data: ItemData) -> void:

	item_data = _item_data

	for button in button_list.get_children():

		button.hide()

	if item_data == null:

		return

	item_data.data_updated.connect(_on_item_data_updated)

	_update_label()

	discard_button.show()





func _update_label() -> void:

	var item_def = item_data.get_def()

	item_name_label.text = "%s (%s)" % [item_def.display_name, item_data.get_count()]







func _get_all_buttons() -> Array:

	return button_list.get_children()





func _on_item_data_updated(_item_data: ItemData) -> void:

	_update_label()