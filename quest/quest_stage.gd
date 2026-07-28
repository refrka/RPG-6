class_name QuestStage extends Resource


signal objective_completed(objective: QuestObjective)

signal stage_completed


@export var objectives: Array[QuestObjective]

var completed_objectives: Array[QuestObjective]



func initialize() -> void:

	for objective in objectives:

		if !objective.objective_complete.is_connected(_on_objective_complete):

			objective.objective_complete.connect(_on_objective_complete)

		if !completed_objectives.has(objective):

			objective._initialize()

		if objective._is_complete():

			objective.objective_complete.emit(objective)




func get_objective_index(objective: QuestObjective) -> int:

	if objectives.has(objective):

		return objectives.find(objective)

	return -1




func _on_objective_complete(objective: QuestObjective) -> void:

	completed_objectives.append(objective)

	objective_completed.emit(objective)

	var stage_complete = true

	for _objective in objectives:

		if !completed_objectives.has(_objective):

			stage_complete = false

	if stage_complete:

		stage_completed.emit()