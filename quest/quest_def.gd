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

@export var recipient_entity_id: StringName

@export var recipient_unique_id: StringName

@export var stages: Array[QuestStage]




@export var available_condition_set: ConditionSet

@export var source_dialogue_node: QuestDialogueNode

@export var submit_dialogue_node: QuestDialogueNode