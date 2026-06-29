class_name IsQuestState extends ConditionFunction



@export var quest_id: StringName

@export var quest_state: QuestData.QuestState





func evaluate(_data: Dictionary = {}) -> bool:

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("quest_state"):

		quest_state = _data["quest_state"] as QuestData.QuestState

	return Quests.get_quest_state(quest_id) == quest_state