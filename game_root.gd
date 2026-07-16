extends Node








func _ready() -> void:

	Events.subscribe(LocationDiscoveredEvent, _on_disco)

	Game.launch()



func _on_disco(event: Event) -> void:

	print(event)