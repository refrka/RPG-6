class_name EntityMarker extends Marker2D




@export var entity_node_scene: PackedScene

@export var entity_def: EntityDef

@export var spawn_condition_set: ConditionSet





func get_def() -> EntityDef:

	return entity_def



func get_entity_node() -> EntityNode:

	if entity_node_scene:
		
		return entity_node_scene.instantiate()

	if entity_def.scene_path != "":

		return load(entity_def.scene_path).instantiate()

	return null