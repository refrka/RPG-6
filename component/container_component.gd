class_name ContainerComponent extends InteractableComponent




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func interact() -> bool:

	var movement_component = Game.get_player().get_component("movement")

	movement_component.can_move = false

	return true




func end() -> void:

	var movement_component = Game.get_player().get_component("movement")

	movement_component.can_move = false


