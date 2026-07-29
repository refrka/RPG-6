class_name StartDialogueObjective extends QuestObjective



@export var target_quest_entity: QuestEntity



func _initialize() -> void:

	Events.subscribe(DialogueStartingEvent, _on_dialogue_starting)



func _complete() -> void:

	Events.unsubscribe(DialogueStartingEvent, _on_dialogue_starting)




func _on_dialogue_starting(event: Event) -> void:

	if !target_quest_entity or target_quest_entity.match(event.data["entity_node"]):

		objective_complete.emit(self)