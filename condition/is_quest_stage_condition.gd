class_name IsQuestStageCondition extends Condition


@export var quest_def: QuestDef

@export var quest_id: StringName

@export var stage_index: int




func evaluate(_data: Dictionary = {}) -> bool:

	if _data.has("quest_def"):

		quest_def = _data["quest_def"]

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("stage_index"):

		stage_index = _data["stage_index"]

	if !quest_def:

		quest_def = Quests.get_quest_def(quest_id)

	var quest_data = Quests.get_quest_data(quest_def)

	if !quest_data:

		if stage_index == -1:

			return true

		return false

	return quest_data.stage_index == stage_index