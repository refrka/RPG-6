class_name ReferenceEntity extends Resource



@export var entity_def: EntityDef

@export var unique_id: StringName

@export var entity_id: StringName



func match(entity_node: EntityNode) -> bool:

	if entity_def and entity_node.get_entity_def() == entity_def:

		return true

	if unique_id != &"" and entity_node.get_unique_id() == unique_id:

		return true

	if entity_id != &"" and entity_node.get_entity_id() == entity_id:

		return true

	return false