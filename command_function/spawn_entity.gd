class_name SpawnEntity extends CommandFunction


@export var entity_id: StringName

@export var unique_id: StringName

@export var spawn_id: StringName

@export var target_pos: Vector2



func execute(_data: Dictionary = {}) -> bool:

	var def: EntityDef = null

	if entity_id != &"":

		def = Entities.get_entity_def(entity_id)

	elif unique_id != &"":

		def = Entities.get_unique_def(unique_id)

	var entity_node = Entities.create_node(def)

	var location_scene = Scenes.get_scene(LocationScene)

	location_scene.add_entity_node(entity_node)

	if spawn_id != &"":

		var spawn_point = location_scene.get_spawn_point(spawn_id)

		target_pos = spawn_point.global_position

	entity_node.global_position = target_pos

	command_executed.emit()

	return true