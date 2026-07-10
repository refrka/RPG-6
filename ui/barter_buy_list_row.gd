class_name BarterBuyListRow extends PanelContainer


signal buy_requested(item_data: ItemData, count: int)



@export var item_label: Label

@export var buy_button: Button

@export var count_entry: LineEdit



var item_data: ItemData

var current_count_entry: String



func _ready() -> void:

	buy_button.pressed.connect(_on_buy_pressed)

	count_entry.text_changed.connect(_on_count_entry_text_changed)




func set_data(_item_data: ItemData) -> void:

	item_data = _item_data

	item_data.count_updated.connect(_on_count_updated)

	update_label()






func update_label() -> void:

	item_label.text = "%s (%s)" % [item_data.get_def().display_name, item_data.get_count()]





func _on_count_updated(_amount: int, _item_data: ItemData, _removed: bool) -> void:

	if item_data.get_count() <= 0:

		queue_free()

	else:

		update_label()




	

func _on_buy_pressed() -> void:

	if !count_entry.text.is_valid_int():

		return

	var count = int(count_entry.text)

	buy_requested.emit(item_data, count)






func _on_count_entry_text_changed(text: String) -> void:

	if !text.is_valid_int() or int(text) > item_data.get_count():

		count_entry.text = current_count_entry

		count_entry.caret_column = text.length()

	else:

		current_count_entry = text