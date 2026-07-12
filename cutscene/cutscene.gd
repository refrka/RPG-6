class_name Cutscene extends Resource



@export var cutscene_id: StringName

@export var location_id: StringName

@export var actions: Array[CutsceneAction]

var action_index:= 0



func start() -> void:

	var location_scene = Scenes.get_scene(LocationScene)

	if location_scene.location_id != location_id:

		Game.load_location(location_id)

	execute_action()





func execute_action() -> void:

	var action = actions[action_index]

	action.action_completed.connect(_on_action_completed)

	action.execute()




func _on_action_completed() -> void:

	action_index += 1

	if action_index <= actions.size() - 1:

		execute_action()

	else:

		action_index = 0

		var player = Game.get_player()

		player._enable()