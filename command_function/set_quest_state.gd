class_name SetQuestState extends CommandFunction


@export var quest_id: StringName

@export var quest_state: QuestData.QuestState



func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("quest_state"):

		quest_state = _data["quest_state"] as QuestData.QuestState

	var quest_data = Quests.set_quest_state(quest_id, quest_state)

	if quest_data == null:

		return false

	return true