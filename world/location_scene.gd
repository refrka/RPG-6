class_name LocationScene extends GameScene


@export var location_id: StringName

@export var spawn_root: Node2D

@export var character_root: Node2D

@export var object_root: Node2D

@export var transition_root: Node2D


var data: LocationData












func _enter() -> void:

	_activate()

	var location_data = Game.get_location_data(location_id)

	_load_data(location_data)

	_initialize_characters()

	_initialize_features()




func _exit() -> void:

	_deactivate()





func _initialize_characters() -> void:

	for character_node in character_root.get_children():

		character_node._initialize()




func _initialize_features() -> void:

	for zone in transition_root.get_children():

		zone._initialize()




func spawn_entity(entity_node: EntityNode, spawn_id: StringName) -> void:

	_add_entity_node(entity_node)

	entity_node.global_position = get_spawn_position(spawn_id)





func get_spawn_point(spawn_id: StringName) -> SpawnPoint:

	for spawn_point in spawn_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point

	return null




func get_spawn_position(spawn_id: StringName) -> Vector2:

	var spawn_point = get_spawn_point(spawn_id)

	assert(spawn_point != null, "Invalid spawn_id %s in location %s" % [spawn_id, location_id])

	return spawn_point.global_position








func _add_entity_node(entity_node: EntityNode) -> void:

	var root: Node2D = null

	if entity_node is CharacterNode:

		root = character_root

	elif entity_node is ObjectNode:

		root = object_root

	if entity_node.get_parent() != null:

		entity_node.reparent(root)
		
	else:

		root.add_child(entity_node)




func _load_data(location_data: LocationData) -> void:

	if location_data == null:

		location_data = LocationData.new()

		location_data.location_id = location_id

	data = location_data