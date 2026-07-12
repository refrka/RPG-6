class_name SpawnEntity extends CommandFunction


@export var entity_id: StringName

@export var unique_id: StringName

@export var spawn_id: StringName

@export var target_pos: Vector2



func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	var def: EntityDef = null

	var entity_node: EntityNode = null

	if data.has("entity_id"):

		entity_id = data["entity_id"]

	if data.has("unique_id"):

		unique_id = data["unique_id"]

	if data.has("entity_def"):

		def = data["entity_def"]

	elif entity_id != &"":

		def = Entities.get_entity_def(entity_id)

	elif unique_id != &"":

		def = Entities.get_unique_def(unique_id)

	if data.has("entity_node"):

		entity_node = data["entity_node"]

	else:

		entity_node = Entities.create_node(def)

	var location_scene = Scenes.get_scene(LocationScene)

	location_scene.add_entity_node(entity_node)

	if spawn_id != &"":

		var spawn_point = location_scene.get_spawn_point(spawn_id)

		target_pos = spawn_point.global_position

	entity_node.global_position = target_pos

	command_executed.emit()

	return true