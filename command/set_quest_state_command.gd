class_name SetQuestStateCommand extends Command


@export var quest_def: QuestDef

@export var quest_id: StringName

@export var state: QuestData.QuestState





func execute(_data: Dictionary = {}) -> bool:

	if _data.has("state"):

		state = _data["state"]

	if _data.has("quest_def"):

		quest_def = _data["quest_def"]

	if !quest_def:

		if _data.has("quest_id"):

			quest_id = _data["quest_id"]

		quest_def = Quests.get_quest_def(quest_id)

	Quests.set_quest_state(quest_def, state)

	return true