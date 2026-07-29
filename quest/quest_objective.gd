class_name QuestObjective extends Resource


@warning_ignore("unused_signal")

signal objective_complete(objective: QuestObjective)


@export var title: String

@export_multiline var description: String

@export var dialogue_nodes: Array[DialogueNode]



func _initialize() -> void:

	pass




func _complete() -> void:

	pass




func _is_complete() -> bool:

	return false