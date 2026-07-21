extends Node



var def_registry: Dictionary[StringName, EntityDef]







func _ready() -> void:

	_load_entity_defs()

	process_mode = Node.PROCESS_MODE_ALWAYS






func get_entity_def_by_entity_id(entity_id: StringName) -> EntityDef:

	if def_registry.has(entity_id):

		return def_registry[entity_id]

	return null



func get_entity_def_by_unique_id(unique_id: StringName) -> EntityDef:

	for entity_def in def_registry.values():

		if entity_def.unique_id == unique_id:

			return entity_def

	return null



func get_player_node() -> PlayerNode:

	return load("res://player/player.tscn").instantiate()






func find_entity_node_from_reference(reference_entity: ReferenceEntity) -> EntityNode:

	var entity_node: EntityNode = null

	return entity_node





func create_entity_node(entity_def: EntityDef) -> EntityNode:

	if entity_def.scene_path != "":

		return load(entity_def.scene_path).instantiate()

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
