class_name QuestDef extends Resource



enum QuestType {

	MAIN,

	SIDE,

	TASK,

}



@export var quest_id: StringName

@export var type: QuestType