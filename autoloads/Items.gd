extends Node



var def_registry: Dictionary[StringName, ItemDef]







func _ready() -> void:

	_load_item_defs()







func get_item_def(item_id: StringName) -> ItemDef:

	if def_registry.has(item_id):

		return def_registry[item_id]

	return null




func get_value_of_items(item_list: Dictionary[ItemData, int]) -> int:

	var total:= 0

	for item_data in item_list:

		var count = item_list[item_data]

		var def = item_data.get_def()

		total = total + (def.gold_value * count)

	return  total




func create_data(item_def: ItemDef, count:= 1, with_data_id:= false) -> ItemData:

	var item_data = ItemData.new()

	item_data.item_def = item_def

	item_data.count = count

	if with_data_id and count == 1:

		item_data.data_id = _generate_data_id(item_def.item_id)

	return item_data








func _generate_data_id(item_id: StringName) -> StringName:

	var data_id = &"%s_%s" % [item_id, randi()]

	return data_id







func _load_item_defs() -> void:

	var sub_dirs = ["res://item/", "res://equipment/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with("_def.tres"):

				var def = load(path)

				def_registry[def.item_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)