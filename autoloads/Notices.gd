extends Node





func _ready() -> void:

	Events.subscribe(ItemsAddedToInventoryEvent, _on_event)

	Events.subscribe(ItemsRemovedFromInventoryEvent, _on_event)

	Events.subscribe(QuestStartedEvent, _on_event)

	Events.subscribe(QuestCompletedEvent, _on_event)




func _on_event(event: Event) -> void:

	NoticeGenerator.event_to_notice(event)