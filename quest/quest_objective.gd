class_name QuestObjective extends Resource


@warning_ignore("unused_signal")

signal completed(objective: QuestObjective)

@export_multiline var description: String

@export var dialogue_nodes: Array[DialogueNode]


var counter:= 0



func _initialize() -> void:

	pass






func _is_complete() -> bool:

	return true