class_name QuestSource extends Resource


@export var unique_id: StringName

@export var entity_id: StringName





func match(entity_node: EntityNode) -> bool:

	if entity_node.get_unique_id() == unique_id:

		return true

	if entity_node.get_entity_id() == entity_id:

		return true

	if entity_node.get_template_id() == entity_id:

		return true

	return false