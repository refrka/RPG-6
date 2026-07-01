class_name SubmitQuest extends CommandFunction








func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	Quests.set_quest_state(data["quest_id"], QuestData.QuestState.COMPLETE)

	return true