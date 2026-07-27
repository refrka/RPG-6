class_name Location extends Node2D





@export var location_id: StringName


@export_group("Node References")

@export var character_root: Node2D

@export var object_root: Node2D

@export var marker_root: Node2D

@export var transition_root: Node2D

@export var spawn_point_root: Node2D

@export var nav_region: NavigationRegion2D



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

	initialize_objects()

	spawn_marked_entities()

	return true





func _unload() -> void:

	for object_node in object_list:

		var dict = object_node._get_dictionary()

		Entities.store_entity_dict(dict)









func spawn_marked_entities() -> void:

	for entity_marker in marker_root.get_children():

		if entity_marker.spawn_condition_set and !entity_marker.spawn_condition_set.evaluate({"location": self}):

			continue

		var entity_node = entity_marker.reference_entity.get_reference_node()

		_add_entity(entity_node)

		entity_node.reposition(entity_marker.global_position)

		entity_node._initialize()

		entity_node._activate()





func spawn_entity_node(entity_node: EntityNode, spawn_id: StringName) -> void:

	_add_entity(entity_node)

	var spawn_point = get_spawn_point(spawn_id)

	entity_node.reposition(spawn_point.global_position)

	entity_node._initialize()

	entity_node._activate()

	entity_node.show()

	if entity_node is PlayerNode:

		entity_node.active_spawn_point = spawn_point





func initialize_objects() -> void:

	for object_node in object_root.get_children():

		object_node._initialize()

		object_node.authored = true

		object_list.append(object_node)



func initialize_characters() -> void:

	for character_node in object_root.get_children():

		character_node._initialize()

		character_node.authored = true

		character_list.append(character_node)
























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

	process_mode = Node.PROCESS_MODE_INHERIT










func _enter() -> void:

	pass


func _exit() -> void:

	pass
















func _add_entity(entity_node: EntityNode) -> void:

	if has_entity_node(entity_node):

		return

	if entity_node.is_inside_tree():

		entity_node.get_parent().remove_child(entity_node)

	if entity_node is ObjectNode:

		object_root.add_child(entity_node)

		object_list.append(entity_node)

	elif entity_node is CharacterNode:

		character_root.add_child(entity_node)

		character_list.append(entity_node)




func _remove_entity(entity_node: EntityNode) -> void:

	if !has_entity_node(entity_node):

		return

	if entity_node is ObjectNode:

		object_root.remove_child(entity_node)

		object_list.erase(entity_node)

	elif entity_node is CharacterNode:

		character_root.remove_child(entity_node)

		character_list.erase(entity_node)




















func _activate() -> void:

	active = true

	for object in object_list:

		object._activate()

	for character in character_list:

		character._activate()



func _deactivate() -> void:

	active = false

	for object in object_list:

		object._deactivate()

	for character in character_list:

		character._deactivate()