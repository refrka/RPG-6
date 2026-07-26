class_name BarterCountSelector extends CountSelector


@export var total_value_label: Label


var item_def: ItemDef





func _on_count_changed(value: float) -> void:

	super(value)

	var total_value = item_def.gold_value * int(value)

	total_value_label.text = str(total_value)

