class_name QuestStage extends Resource


signal objective_completed(objective: QuestObjective, stage: QuestStage)



@export var objectives: Array[QuestObjective]




func _initialize() -> void:

	for objective in objectives:

		objective.completed.connect(_on_quest_objective_completed)

		objective._initialize()







func _on_quest_objective_completed(objective: QuestObjective) -> void:

	objective.completed.disconnect(_on_quest_objective_completed)

	objective_completed.emit(objective, self)



