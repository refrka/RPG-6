extends Node




var scene_registry:= {}


var active_scene: GameScene

var active_cutscene: Cutscene





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene




func unregister_scene(scene: GameScene) -> void:

	scene_registry.erase(scene.get_script())




func activate_scene(scene_script: Script) -> GameScene:

	var scene = get_scene(scene_script)

	if active_scene:

		active_scene._deactivate()

	active_scene = scene

	scene._activate()

	return scene








func start_cutscene(cutscene: Cutscene) -> void:

	active_cutscene = cutscene

	cutscene.finished.connect(_on_cutscene_finished)

	cutscene.paused_location_id = get_scene(LocationScene).location_id

	var player = Game.get_player()

	cutscene.paused_position = player.global_position

	cutscene._start()







func get_scene(scene_script: Script = null) -> GameScene:

	if scene_script == null:

		return active_scene

	if !scene_registry.has(scene_script):

		for script in scene_registry:

			if script.get_base_script() == scene_script:

				return script
		
		return null

	return scene_registry[scene_script]




func get_location_scene(location_id: StringName) -> LocationScene:

	var location_scene: LocationScene = get_scene(LocationScene)

	if location_scene and location_scene.location_id == location_id:

		return location_scene

	var path = "res://world/locations/%s.scn" % location_id

	if !FileAccess.file_exists(path):

		return null

	location_scene = load(path).instantiate()

	return location_scene




func get_cutscene(cutscene_id: StringName) -> Cutscene:

	var path = "res://cutscene/%s.tres" % cutscene_id

	assert(FileAccess.file_exists(path), "Invalid cutscene_id: %s" % cutscene_id)

	return load(path)




func start_timer(time: float) -> SceneTreeTimer:

	var timer = get_tree().create_timer(time)

	return timer




func _load_scene(scene_script: Script) -> GameScene:

	var scene: GameScene = null

	if scene_registry.has(scene_script):

		scene = scene_registry[scene_script]

	if scene != null:

		if active_scene:

			active_scene._deactivate()

		scene._activate()

	return scene









func _on_cutscene_finished() -> void:

	var world_scene = get_scene(WorldScene)

	world_scene.load_location(active_cutscene.paused_location_id)

	active_cutscene.finished.disconnect(_on_cutscene_finished)

	active_cutscene = null