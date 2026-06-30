class_name StartDialogueObjective extends QuestObjective



@export var target_entity_id: StringName

@export var target_unique_id: StringName



func _initialize() -> void:

	Events.subscribe(DialogueStartedEvent, _on_dialogue_started)





func _on_dialogue_started(event: DialogueStartedEvent) -> void:

	var complete = false

	var entity_node = event.data["entity_node"]

	if entity_node.get_entity_id() == target_entity_id:

		complete = true

	if entity_node.get_unique_id() == target_unique_id:

		complete = true

	if complete:

		completed.emit(self)