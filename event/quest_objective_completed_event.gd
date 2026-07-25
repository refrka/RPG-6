class_name QuestObjectiveCompletedEvent extends GameEvent







func _get_notice_primary_text() -> String:

	return "Objective complete"




func _get_notice_secondary_text() -> String:

	var quest_objective = data["quest_objective"]

	return quest_objective.title