class_name SetQuestStageCommand extends Command



@export var quest_def: QuestDef

@export var quest_id: StringName

@export var stage_index: int





func execute(_data: Dictionary = {}) -> bool:

	if _data.has("quest_def"):

		quest_def = _data["quest_def"]

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("stage_index"):

		stage_index = _data["stage_index"]

	if !quest_def:

		quest_def = Quests.get_quest_def(quest_id)

	Quests.set_quest_stage(quest_def, stage_index)
	
	return true