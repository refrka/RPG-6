class_name QuestDialogueNode extends DialogueNode


enum QuestDialogueNodeType {

	SOURCE,

	OBJECTIVE,

	RECIPIENT,

}

@export var quest_id: StringName

@export var type: QuestDialogueNodeType

@export var quest_entity: QuestEntity