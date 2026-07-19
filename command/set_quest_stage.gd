class_name SetQuestStage extends Command


@export var quest_id: StringName

@export var stage: int



func execute(_data: Dictionary = {}) -> bool:

	if _data.has("quest_id"):

		quest_id = _data["quest_id"]

	if _data.has("quest_def"):

		quest_id = _data["quest_def"].quest_id

	if _data.has("stage"):

		stage = _data["stage"]

	Quests.set_quest_stage(quest_id, stage)

	return true