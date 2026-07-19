class_name QuestStage extends Resource


signal objective_completed(objective: QuestObjective, stage: QuestStage)



@export var objectives: Array[QuestObjective]




func _initialize() -> void:

	for objective in objectives:

		if !objective.completed.is_connected(_on_quest_objective_completed):

			objective.completed.connect(_on_quest_objective_completed)

		objective._initialize()











func get_dialogue_nodes() -> Array[DialogueNode]:

	var dialogue_nodes: Array[DialogueNode] = []

	for objective in objectives:

		dialogue_nodes.append_array(objective.dialogue_nodes)

	return dialogue_nodes






func _on_quest_objective_completed(objective: QuestObjective) -> void:

	objective.completed.disconnect(_on_quest_objective_completed)

	objective_completed.emit(objective, self)


