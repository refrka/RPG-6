class_name GreetCharacterObjective extends QuestObjective




@export var target_quest_entity: QuestEntity




func _initialize() -> void:

	Events.subscribe(DialogueStartedEvent, _on_dialogue_started)



func _complete() -> void:

	Events.unsubscribe(DialogueStartedEvent, _on_dialogue_started)



func _is_complete() -> bool:

	var entity_def = target_quest_entity.get_reference_def()

	if entity_def.unique_id == &"":

		return false

	return Globals.get_var("greeted_characters").has(entity_def.unique_id)




func _on_dialogue_started(event: Event) -> void:

	var entity_node = event.data["entity_node"]

	if target_quest_entity.match(entity_node):

		objective_complete.emit(self)
