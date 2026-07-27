class_name PlayerAddedItemsTrigger extends Trigger


@export var item_def: ItemDef

@export var amount:= 1




func _initialize() -> void:

	Events.subscribe(PlayerAddedItemsEvent, _on_player_added_items)




func _on_player_added_items(event: Event) -> void:

	var item_data = event.data["item_data"]

	var count = event.data["count"]

	if item_data.get_item_def() == item_def and count >= amount:

		_trigger()