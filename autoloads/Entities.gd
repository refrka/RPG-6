extends Node





var def_registry: Dictionary[StringName, EntityDef]







func _ready() -> void:

	_load_entity_defs()









func get_entity_def(entity_id: StringName) -> EntityDef:

	if def_registry.has(entity_id):

		return def_registry[entity_id]

	return null



func get_unique_def(unique_id: StringName) -> EntityDef:

	for def in def_registry.values():

		if def.unique_id == unique_id:

			return def

	return null



func create_node(entity_def: EntityDef) -> EntityNode:

	var node_scene = load(entity_def.scene_path)

	return node_scene.instantiate()





func create_data(entity_node: EntityNode) -> EntityData:

	var entity_data = EntityData.new()

	entity_data.data_id = _generate_data_id(entity_node.get_def())

	entity_data.def = entity_node.def

	entity_data.node = entity_node

	return entity_data





func _generate_data_id(def: EntityDef) -> StringName:

	return &"%s_%s" % [def.entity_id, randi()]

	







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