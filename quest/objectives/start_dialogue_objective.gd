class_name StartDialogueObjective extends QuestObjective



@export var target_quest_entity: QuestEntity



func _initialize() -> void:

	Events.subscribe(DialogueStartedEvent, _on_dialogue_started)



func _on_dialogue_started(event: Event) -> void:

	if target_quest_entity.match(event.data["source"]):

		objective_complete.emit(self)