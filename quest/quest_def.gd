class_name QuestDef extends Resource



enum QuestType {

	MAIN,

	SIDE,

	TASK,

}



@export var quest_id: StringName

@export var type: QuestType

@export var title: String

@export var sources: Array[QuestSource]

@export var recipients: Array[QuestRecipient]

@export var stages: Array[QuestStage]

@export var source_dialogue_node: DialogueNode

@export var recipient_dialogue_node: DialogueNode



@export var available_condition_set: ConditionSet