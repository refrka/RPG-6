class_name EnterDialogueNodeObjective extends QuestObjective



@export var target_dialogue_node: DialogueNode




func _initialize() -> void:

	Events.subscribe(DialogueNodeEnteredEvent, _on_dialogue_node_entered)






func _on_dialogue_node_entered(event: Event) -> void:

	if event["dialogue_node"] == target_dialogue_node:

		print("we found the node")

		completed.emit(self)