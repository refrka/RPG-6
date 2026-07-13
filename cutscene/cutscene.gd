class_name Cutscene extends Resource


signal cutscene_finished


@export var cutscene_id: StringName

@export var location_id: StringName

@export var actions: Array[CutsceneAction]

var action_index:= 0


var current_location_scene: LocationScene







func start() -> void:

	current_location_scene = Scenes.get_scene(LocationScene)

	Game.load_location(location_id)

	execute_action()





func execute_action() -> void:

	var action = actions[action_index]

	action.action_completed.connect(_on_action_completed, CONNECT_ONE_SHOT)

	action.execute()









func _end() -> void:

	cutscene_finished.emit()







func _on_action_completed() -> void:

	action_index += 1

	if action_index <= actions.size() - 1:

		execute_action()

	else:

		action_index = 0

		_end()

