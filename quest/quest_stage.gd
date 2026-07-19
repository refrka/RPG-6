class_name QuestStage extends Resource


signal objective_completed(objective: QuestObjective, stage: QuestStage)



@export var objectives: Array[QuestObjective]




func _initialize() -> void:

	for objective in objectives:

		if !objective.completed.is_connected(_on_quest_objective_completed):

			objective.completed.connect(_on_quest_objective_completed)

		objective._initialize()











func get_dialogue_nodes(entity_node: EntityNode = null) -> Array[DialogueNode]:

	var dialogue_nodes: Array[DialogueNode] = []

	for objective in objectives:

		var related_nodes = objective.dialogue_nodes.filter(func(node): return node.quest_entity.match(entity_node))

		dialogue_nodes.append_array(related_nodes)

	return dialogue_nodes






func _on_quest_objective_completed(objective: QuestObjective) -> void:

	objective.completed.disconnect(_on_quest_objective_completed)

	objective_completed.emit(objective, self)


