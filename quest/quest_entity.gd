class_name QuestEntity extends Resource




@export var unique_id: StringName

@export var entity_id: StringName

@export var entity_def: EntityDef



func match(entity_node: EntityNode) -> bool:

	if unique_id != &"" and entity_node.get_unique_id() == unique_id:

		return true

	if entity_id != &"" and entity_node.get_entity_id() == entity_id:

		return true

	if entity_def and entity_node.get_def() == entity_def:

		return true

	return false