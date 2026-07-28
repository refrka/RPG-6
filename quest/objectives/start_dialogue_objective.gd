class_name StartDialogueObjective extends QuestObjective



@export var target_quest_entity: QuestEntity



func _initialize() -> void:

	Events.subscribe(DialogueStartedEvent, _on_dialogue_started)



func _complete() -> void:

	Events.unsubscribe(DialogueStartedEvent, _on_dialogue_started)



func _on_dialogue_started(event: Event) -> void:

	if !target_quest_entity or target_quest_entity.match(event.data["entity_node"]):

		objective_complete.emit(self)