class_name IsQuestStateCondition extends Condition



@export var quest_def: QuestDef

@export var quest_id: StringName

@export var quest_state: QuestData.QuestState




func evaluate(_data: Dictionary = {}) -> bool:

	if _data.has("quest_def"):

		quest_def = _data["quest_def"]

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("state"):

		quest_state = _data["quest_state"]

	if !quest_def:

		quest_def = Quests.get_quest_def(quest_id)

	var evaluation = Quests.get_quest_state(quest_def) == quest_state

	if invert:

		evaluation = !evaluation

	return evaluation