class_name PlayerHUD extends MarginContainer




@export var health_bar: ProgressBar


var health_component: HealthComponent



func _ready() -> void:

	Events.subscribe(GameStartedEvent, _on_game_started)

	Events.subscribe(GameEndedEvent, _on_game_ended)






func load_player() -> void:

	var player = Game.get_player()

	health_component = player.get_component(HealthComponent)

	health_component.health_reduced.connect(_on_health_reduced)

	health_component.health_restored.connect(_on_health_restored)

	health_bar.max_value = health_component.max_health

	health_bar.value = health_component.current_health







func clear() -> void:

	health_component.health_reduced.disconnect(_on_health_reduced)

	health_component.health_restored.disconnect(_on_health_restored)





func set_health_bar_value(value: float) -> void:

	health_bar.value = value







func _on_game_started(_event: Event) -> void:

	load_player()



func _on_game_ended(_event: Event) -> void:

	clear()



func _on_health_reduced(_amount: float, new_health: float) -> void:

	set_health_bar_value(new_health)



func _on_health_restored(_amount: float, new_health: float) -> void:

	set_health_bar_value(new_health)