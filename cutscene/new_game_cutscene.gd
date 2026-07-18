class_name NewGameCutscene extends Cutscene




@export var command: Command





func _start() -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	world_scene.load_location("forest_area_1")

	await Scenes.start_timer(3.0).timeout

	command.execute()

	await Dialogue.dialogue_finished

	_end()

