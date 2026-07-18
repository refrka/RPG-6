class_name SetQuestState extends Command


@export var quest_id: StringName

@export var quest_state: QuestData.QuestState




func execute(_data: Dictionary = {}) -> bool:

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("quest_state"):

		quest_state = _data["quest_state"]

	Quests.set_quest_state(quest_id, quest_state)

	return true