class_name EntityMarker extends Marker2D




@export var reference_entity: ReferenceEntity

@export var spawn_condition_set: ConditionSet

@export var scene_path: String

var spawned_entity_node: EntityNode





func get_entity_node() -> EntityNode:

	if reference_entity:

		return reference_entity.get_reference_node()

	if scene_path != "":

		return load(scene_path).instantiate()

	return null