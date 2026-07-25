class_name QuestStateChangedEvent extends GameEvent






func _get_notice_primary_text() -> String:

	var quest_data = data["quest_data"]

	var old_state = data["old_state"]

	match quest_data.get_state():

		QuestData.QuestState.ACTIVE:

			if old_state == QuestData.QuestState.UNKNOWN or old_state == QuestData.QuestState.AVAILABLE:

				return "Quest started"

		QuestData.QuestState.COMPLETE:

			return "Quest completed"

	return "Quest state changed"