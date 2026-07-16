class_name NewGameCutscene extends Cutscene






func _start() -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	world_scene.load_location("forest_area_1")

	print("loaded")

	await Scenes.start_timer(3.0).timeout

	print("awaited")

	_end()