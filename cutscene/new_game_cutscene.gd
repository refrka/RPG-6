class_name NewGameCutscene extends Cutscene




@export var command: Command





func _start() -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	var location_scene = world_scene.load_location(location_id)

	UI.show_notice("shit", "")

	await Scenes.start_timer(3.0).timeout

	_end()

