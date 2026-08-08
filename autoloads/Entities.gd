extends Node



@onready var projectile_node_scene = preload("res://entity/object/projectiles/projectile_node.tscn")



var def_registry: Dictionary[StringName, EntityDef]


## This array is a list of every entity's save_dict from _get_dictionary().
## It must be tended to, so no duplicate dicts are stored
var stored_entity_dicts: Array[Dictionary]





func _ready() -> void:

	_load_entity_defs()

	process_mode = Node.PROCESS_MODE_ALWAYS






func store_entity_dict(dict: Dictionary) -> void:

	if dict.has("unique_id"):

		var unique_dicts = get_stored_dicts_with("unique_id", dict["unique_id"])

		if !unique_dicts.is_empty():

			var current_dict = unique_dicts.pop_front()

			stored_entity_dicts.erase(current_dict)

	stored_entity_dicts.append(dict)





func get_stored_dicts_with(property_name: String, value: Variant) -> Array[Dictionary]:

	var stored_dicts: Array[Dictionary] = []

	for dict in stored_entity_dicts:

		if dict.has(property_name) and dict.get(property_name) == value:

			stored_dicts.append(dict)

	return stored_dicts




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

	return load("res://player/player_node.tscn").instantiate()






func find_entity_node_from_reference(reference_entity: ReferenceEntity) -> EntityNode:

	var entity_node: EntityNode = null

	return entity_node





func create_entity_node(entity_def: EntityDef) -> EntityNode:

	if entity_def.scene_path != "":

		return load(entity_def.scene_path).instantiate()

	return null






func create_entity_data(entity_def: EntityDef) -> EntityData:

	var entity_data: EntityData = null

	if entity_def is CharacterDef:

		entity_data = CharacterData.new()

	elif entity_def is ObjectDef:

		entity_data = ObjectData.new()

	entity_data.entity_def = entity_def

	return entity_data





	

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
