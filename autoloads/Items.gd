extends Node



var def_registry: Dictionary[StringName, ItemDef]







func _ready() -> void:

	_load_item_defs()







func get_item_def(item_id: StringName) -> ItemDef:

	if def_registry.has(item_id):

		return def_registry[item_id]

	return null






func _load_item_defs() -> void:

	var sub_dirs = ["res://item/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with("_def.tres"):

				var def = load(path)

				def_registry[def.item_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)