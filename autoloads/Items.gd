extends Node






var def_registry: Dictionary[StringName, ItemDef]






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_load_item_defs()






func get_item_def(item_id: StringName) -> ItemDef:

	if def_registry.has(item_id):

		return def_registry[item_id]

	return null





func create_item_data(item_def: ItemDef, amount:= -1) -> ItemData:

	var item_data: ItemData = null

	if item_def is EquipmentDef:

		item_data = EquipmentData.new()

	else:

		item_data = ItemData.new()

	item_data.item_def = item_def

	if amount != -1:

		item_data.count = amount

	return item_data






func _load_item_defs() -> void:

	var sub_dirs = ["res://item/", "res://equipment/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for file_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + file_name

			if path.ends_with("_def.tres"):

				var def = load(path) as ItemDef

				def_registry[def.item_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)