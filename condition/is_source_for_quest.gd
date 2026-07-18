class_name IsSourceForQuest extends Condition


@export var quest_id: StringName

@export var quest_def: QuestDef





func evaluate(data: Dictionary = {}) -> bool:

	if data.has("quest_id"):

		quest_id = data["quest_id"]

	if data.has("quest_def"):

		quest_def = data["quest_def"]

	if !quest_def:

		quest_def = Quests.get_quest_def(quest_id)

	if !quest_def.source_dialogue_node:

		return false

	var entity_node = data["entity_node"]

	for quest_source in quest_def.sources:

		if quest_source.match(entity_node):

			return true

	return false




static func run(data: Dictionary = {}) -> bool:

	var condition = IsSourceForQuest.new()

	return condition.evaluate(data)