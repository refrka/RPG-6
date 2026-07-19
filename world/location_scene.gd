class_name LocationScene extends GameScene


@export var location_id: StringName

@export var spawn_root: Node2D

@export var character_root: Node2D

@export var object_root: Node2D

@export var transition_root: Node2D

@export var nav_region: NavigationRegion2D


@export var enter_condition_command_set: ConditionCommandSet



var data: LocationData








func _enter() -> void:

	_activate()

	var location_data = Game.get_location_data(location_id)

	_load_data(location_data)

	_initialize_characters()

	_initialize_objects()

	_initialize_features()

	if enter_condition_command_set:

		var passed = true
		
		if enter_condition_command_set.condition_set and !enter_condition_command_set.condition_set.evaluate({"location_scene": self}):

			passed = false

		if passed:
			
			enter_condition_command_set.command_set.execute({"location_scene": self})




func _exit() -> void:

	_deactivate()




func _activate() -> void:

	print("activating location")

	super()

	# for character_node in character_root.get_children():

	# 	character_node._setup()





func _initialize_characters() -> void:

	for child in character_root.get_children():

		if child is CharacterNode:

			var character_node = child as CharacterNode

			character_node._initialize()

		elif child is EntityMarker:

			var entity_marker = child as EntityMarker

			spawn_marker(entity_marker)




func _initialize_objects() -> void:

	for child in object_root.get_children():

		if child is ObjectNode:

			var object_node = child as ObjectNode

			object_node._initialize()

		elif child is EntityMarker:

			var entity_marker = child as EntityMarker

			spawn_marker(entity_marker)




func _initialize_features() -> void:

	for zone in transition_root.get_children():

		zone._initialize()










func spawn_entity(entity_node: EntityNode, spawn_id: StringName) -> void:

	_add_entity_node(entity_node)

	entity_node.global_position = get_spawn_position(spawn_id)






func spawn_marker(entity_marker: EntityMarker) -> void:

	if entity_marker.spawn_condition_set and !entity_marker.spawn_condition_set.evaluate({"location_scene": self}):

		return

	var entity_node = entity_marker.get_entity_node()

	if !entity_node:

		return

	_add_entity_node(entity_node)

	entity_node.global_position = entity_marker.global_position












func get_spawn_point(spawn_id: StringName) -> SpawnPoint:

	for spawn_point in spawn_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point

	return null





func get_spawn_position(spawn_id: StringName) -> Vector2:

	var spawn_point = get_spawn_point(spawn_id)

	assert(spawn_point != null, "Invalid spawn_id %s in location %s" % [spawn_id, location_id])

	return spawn_point.global_position





func get_nearest_spawn_point(entity_node: EntityNode) -> SpawnPoint:

	var nearest_distance:= INF

	var nearest_spawn: SpawnPoint = null

	for spawn_point in spawn_root.get_children():

		var distance = entity_node.global_position.distance_to(spawn_point.global_position)

		if !nearest_spawn or distance < nearest_distance:

			nearest_distance = distance

			nearest_spawn = spawn_point

	return nearest_spawn





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