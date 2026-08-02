class_name QuestDialogueNode extends DialogueNode


enum QuestDialogueNodeType {

	SOURCE,

	OBJECTIVE,

	RECIPIENT,

}

@export var quest_id: StringName

@export var type: QuestDialogueNodeType

@export var quest_entity: QuestEntity







func can_show() -> bool:

	var quest_def = Quests.get_quest_def(quest_id)

	var quest_state = Quests.get_quest_state(quest_def)

	match type:

		QuestDialogueNodeType.SOURCE:

			if quest_state != QuestData.QuestState.UNKNOWN and quest_state != QuestData.QuestState.AVAILABLE:

				return false

		QuestDialogueNodeType.RECIPIENT:

			if quest_state != QuestData.QuestState.READY:

				return false

	return true