class_name IsRecipientForQuest extends Condition


@export var quest_id: StringName

@export var quest_def: QuestDef





func evaluate(data: Dictionary = {}) -> bool:

	if data.has("quest_id"):

		quest_id = data["quest_id"]

	if data.has("quest_def"):

		quest_def = data["quest_def"]

	if !quest_def:

		quest_def = Quests.get_quest_def(quest_id)

	if !quest_def.recipient_dialogue_node:

		return false

	var entity_node = data["entity_node"]

	for quest_recipient in quest_def.recipients:

		if quest_recipient.match(entity_node):

			return true

	return false




static func run(data: Dictionary = {}) -> bool:

	var condition = IsRecipientForQuest.new()

	return condition.evaluate(data)