class_name ItemListRow extends PanelContainer



@export var item_id_label: Label

@export var item_count_label: Label





func set_data(item_id: StringName, count: int) -> void:

	item_id_label.text = item_id

	item_count_label.text = str(count)