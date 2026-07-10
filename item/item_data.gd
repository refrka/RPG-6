class_name OldItemData extends Resource



var def: ItemDef








func get_item_id() -> StringName:

	return def.item_id






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["item_id"] = def.item_id

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> OldItemData:

	if save_dict.is_empty():

		return null

	var item_data = OldItemData.new()

	item_data.def = Items.get_item_def(save_dict["item_id"])

	return item_data


