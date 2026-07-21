class_name Location extends Node2D





@export var location_id: StringName


@export_group("Node References")

@export var character_root: Node2D

@export var object_root: Node2D

@export var marker_root: Node2D



var initialized:= false





# Location life-cycle steps

# - Loading/initializing

# - Activation

# - Pause/resume

# - Deactivation/Unloading









func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	spawn_marked_entities()

	return true








func pause() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED





func resume() -> void:

	process_mode = Node.PROCESS_MODE_INHERIT












func spawn_marked_entities() -> void:

	for entity_marker in marker_root.get_children():

		var entity_node = entity_marker.reference_entity.get_reference_node()

		_add_entity_to_root(entity_node)

		entity_node.reposition(entity_marker.global_position)

		entity_node._initialize()






func initialize_objects() -> void:

	for object_node in object_root.get_children():

		object_node._initialize()



func initialize_characters() -> void:

	for character_node in object_root.get_children():

		character_node._initialize()












func _add_entity_to_root(entity_node: EntityNode) -> void:

	if entity_node.is_inside_tree():

		entity_node.get_parent().remove_child(entity_node)

	if entity_node is ObjectNode:

		object_root.add_child(entity_node)

	elif entity_node is CharacterNode:

		character_root.add_child(entity_node)