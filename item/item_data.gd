class_name ItemData extends Resource



var def: ItemDef






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = def.item_id

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> ItemData:

	var item_data = ItemData.new()

	item_data.def = Items.get_def(save_dict["item_id"])

	return item_data