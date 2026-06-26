extends Node





var def_registry: Dictionary[StringName, EntityDef]







func _ready() -> void:

	_load_entity_defs()









func get_def(entity_id: StringName) -> EntityDef:

	if def_registry.has(entity_id):

		return def_registry[entity_id]

	return null





func create_data(entity_node: EntityNode) -> EntityData:

	var entity_data = EntityData.new()

	entity_data.def = entity_node.def

	entity_data.node = entity_node

	var save_data = Game.get_save_data()

	save_data.entity_data_list.append(entity_data)

	return entity_data





func _load_entity_defs() -> void:

	var sub_dirs = ["res://entity/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with(".tres"):

				var def = load(path)

				def_registry[def.entity_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)