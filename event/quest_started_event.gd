class_name QuestStartedEvent extends GameEvent





func _get_notice_primary_text() -> String:

	var quest_data = data["quest_data"]

	return quest_data.get_title()



func _get_notice_secondary_text() -> String:

	return "Quest started"