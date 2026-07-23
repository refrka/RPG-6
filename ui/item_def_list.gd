class_name ItemDefList extends OptionButton



func _ready() -> void:

	var item_defs = Items.def_registry.values().duplicate()

	item_defs.sort_custom(_sort_alphabetical)

	for i in range(item_defs.size()):

		var def = item_defs[i]

		var display_name = def.display_name

		add_item(display_name, i)

		set_item_metadata(i, def.item_id)

	var popup = get_popup()

	popup.add_theme_constant_override("v_separation", 16)




func _sort_alphabetical(item_def_a: ItemDef, item_def_b: ItemDef) -> bool:

	return item_def_a.display_name < item_def_b.display_name