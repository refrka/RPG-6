class_name EntityMarker extends Marker2D




@export var reference_entity: ReferenceEntity

@export var spawn_condition_set: ConditionSet

@export var scene_path: String

@export var respawn_on_activate:= false

var spawned_entity_node: EntityNode





func initialize(location: Location) -> void:

	location.entity_removed.connect(_on_entity_removed)





func get_entity_node() -> EntityNode:

	if reference_entity:

		return reference_entity.get_reference_node()

	if scene_path != "":

		return load(scene_path).instantiate()

	return null





func _on_entity_removed(entity_node: EntityNode) -> void:

	if entity_node == spawned_entity_node:

		spawned_entity_node = null