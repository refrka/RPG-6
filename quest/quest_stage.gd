class_name QuestStage extends Resource



@export var objectives: Array[QuestObjective]





func initialize() -> void:

	for objective in objectives:

		objective._initialize()