class_name Location extends Node2D


signal entity_added(entity_node: EntityNode)

signal entity_removed(entity_node: EntityNode)


@export var location_id: StringName


@export_group("Node References")

@export var tile_map: TileMapLayer

@export var character_root: Node2D

@export var object_root: Node2D

@export var item_root: Node2D

@export var marker_root: Node2D

@export var transition_root: Node2D

@export var spawn_point_root: Node2D

@export var feature_root: Node2D

@export var nav_region: NavigationRegion2D



@export var camera_follow_player:= false

@export var camera_limit_top_left: Marker2D

@export var camera_limit_bottom_right: Marker2D




var active:= false

var initialized:= false




var character_list: Array[CharacterNode]

var object_list: Array[ObjectNode]

var feature_list: Array[Feature]



# Location life-cycle steps

# - Loading/initializing

# - Activation

# - Pause/resume

# - Deactivation/Unloading









func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	initialize_features()

	initialize_objects()

	spawn_marked_entities()

	return true





func _unload() -> void:

	for object_node in object_list:

		var dict = object_node._get_dictionary()

		dict["location_id"] = location_id

		Entities.store_entity_dict(dict)









func spawn_marked_entities() -> void:

	for entity_marker in marker_root.get_children():

		if entity_marker.spawn_condition_set and !entity_marker.spawn_condition_set.evaluate({"location": self}):

			continue

		_spawn_marker(entity_marker)




func spawn_entity_node(entity_node: EntityNode, spawn_id: StringName) -> void:

	var spawn_point = get_spawn_point(spawn_id)

	assert(spawn_point != null, "Invalid spawn id: %s" % spawn_id)

	entity_node.reposition(spawn_point.global_position)

	_add_entity(entity_node)

	entity_node._initialize()

	entity_node._activate()

	entity_node.show()




func remove_entity_node(entity_node: EntityNode) -> void:

	_remove_entity(entity_node)





func add_item_node(item_node: DroppedItemNode, target_position: Vector2) -> void:

	item_root.add_child.call_deferred(item_node)

	item_node.global_position = target_position

	item_node.picked_up.connect(_on_item_picked_up.bind(item_node))




func remove_item_node(item_node: DroppedItemNode) -> void:

	_remove_item(item_node)








func initialize_objects() -> void:

	for object_node in object_root.get_children():

		object_node._initialize()

		object_node.authored = true

		_add_entity(object_node, false)



func initialize_characters() -> void:

	for character_node in object_root.get_children():

		character_node._initialize()

		character_node.authored = true

		_add_entity(character_node, false)



func initialize_features() -> void:

	for entity_marker in marker_root.get_children():

		entity_marker.initialize(self)

	for transition_zone in transition_root.get_children():

		transition_zone._initialize()

	for feature in feature_root.get_children():

		feature._initialize()
























func get_location_id() -> StringName:

	return location_id





func get_spawn_point(spawn_id: StringName) -> SpawnPoint:

	for spawn_point in spawn_point_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point

	for transition_zone in transition_root.get_children():

		if transition_zone.get_spawn_point_id() == spawn_id:

			return transition_zone.get_spawn_point()

	return null



func get_all_spawn_points() -> Array[SpawnPoint]:

	var spawn_points: Array[SpawnPoint] = []

	for spawn_point in spawn_point_root.get_children():

		spawn_points.append(spawn_point)

	for transition_zone in transition_root.get_children():

		spawn_points.append(transition_zone.spawn_point)

	return spawn_points











func has_entity_node(entity_node: EntityNode) -> bool:

	if entity_node is ObjectNode:

		return object_list.has(entity_node)

	elif entity_node is CharacterNode:

		return character_list.has(entity_node)

	return false



func is_paused() -> bool:

	return process_mode == Node.PROCESS_MODE_DISABLED












func pause() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED



func resume() -> void:

	for entity_marker in marker_root.get_children():

		var valid = true

		if entity_marker.spawn_condition_set:

			valid = entity_marker.spawn_condition_set.evaluate()

		if !valid:

			if entity_marker.spawn_condition_set and !entity_marker.spawn_condition_set.evaluate():

				remove_entity_node(entity_marker.spawned_entity_node)

				entity_marker.spawned_entity_node = null

		elif !entity_marker.spawned_entity_node and entity_marker.respawn_on_activate:

			_spawn_marker(entity_marker)


	process_mode = Node.PROCESS_MODE_INHERIT










func _enter() -> void:

	pass


func _exit() -> void:

	pass









func _spawn_marker(entity_marker: EntityMarker) -> void:

	if !entity_marker.reference_entity:

		return
	
	var entity_node = entity_marker.get_entity_node()

	_add_entity(entity_node)

	entity_node.reposition(entity_marker.global_position)

	entity_node._initialize()

	entity_marker.spawned_entity_node = entity_node







func _add_entity(entity_node: EntityNode, to_root:= true) -> void:

	if has_entity_node(entity_node):

		return

	var root: Node2D = null

	var list = []

	if entity_node is ObjectNode:

		root = object_root

		list = object_list

	elif entity_node is CharacterNode:

		root = character_root

		list = character_list

	list.append(entity_node)

	await Game.get_tree().process_frame

	if to_root:

		var parent = entity_node.get_parent()

		if parent != null:

			if parent == Game:

				entity_node.reparent(root)

			else:

				parent.remove_child(entity_node)

				root.add_child(entity_node)

		else:

			root.add_child(entity_node)

	entity_node.died.connect(_on_entity_died.bind(entity_node))

	entity_added.emit(entity_node)





func _remove_entity(entity_node: EntityNode) -> void:

	if !has_entity_node(entity_node):

		return

	if entity_node is ObjectNode:

		if entity_node.get_parent() == object_root:

			object_root.remove_child(entity_node)

		object_list.erase(entity_node)

	elif entity_node is CharacterNode:

		if entity_node.get_parent() == character_root:

			character_root.remove_child(entity_node)

		character_list.erase(entity_node)

	entity_node.died.disconnect(_on_entity_died)

	entity_removed.emit(entity_node)




func _remove_item(item_node: DroppedItemNode) -> void:

	item_root.remove_child.call_deferred(item_node)



















func _activate() -> void:

	active = true

	for transition_zone in transition_root.get_children():

		transition_zone._activate()

	for object in object_list:

		object._activate()

	for character in character_list:

		character._activate()

	nav_region.bake_navigation_polygon()

	var camera = Game.get_camera()

	camera.reset_on_location(self)





func _deactivate() -> void:

	active = false

	for object in object_list:

		object._deactivate()

	for character in character_list:

		character._deactivate()

	for item_node in item_root.get_children():

		item_node.queue_free()

	for transition_zone in transition_root.get_children():

		transition_zone._deactivate()

	












func _on_entity_died(entity_node: EntityNode) -> void:

	_remove_entity.call_deferred(entity_node)




func _on_item_picked_up(item_node: DroppedItemNode) -> void:

	_remove_item(item_node)