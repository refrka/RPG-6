extends Node



var def_registry: Dictionary[StringName, EntityDef]







func _ready() -> void:

	_load_entity_defs()

	process_mode = Node.PROCESS_MODE_ALWAYS






func get_entity_def(entity_id: StringName) -> EntityDef:

	if def_registry.has(entity_id):

		return def_registry[entity_id]

	return null






	

func _load_entity_defs() -> void:

	var sub_dirs = ["res://entity/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with("_def.tres"):

				var def = load(path)

				def_registry[def.entity_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)
