class_name EnterDialogueNodeObjective extends QuestObjective



@export var target_dialogue_node: DialogueNode




func _initialize() -> void:

	print("init enter dialogue node obj: ", target_dialogue_node)

	Events.subscribe(DialogueNodeEnteredEvent, _on_dialogue_node_entered)






func _on_dialogue_node_entered(event: Event) -> void:

	print("dialogue node heard")

	if event.data["dialogue_node"] == target_dialogue_node:

		print("entered the correct node!")

		completed.emit(self)