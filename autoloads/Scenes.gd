extends Node




var scene_registry:= {}


var active_scene: GameScene





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS






## Top-level Scene Methods


func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene







func load_scene(scene_script: Script) -> GameScene:

	var scene = _load_scene(scene_script)

	UI.deactivate_overlays()

	return scene





func close_scene(scene_script: Script) -> void:

	var scene = get_scene(scene_script)

	if scene:

		scene.queue_free()

		scene_registry.erase(scene_script)





func get_scene(scene_script: Script) -> GameScene:

	if scene_registry.has(scene_script):

		return scene_registry[scene_script]

	return null






func get_location_scene(location_id: StringName) -> LocationScene:

	var location_scene = get_scene(LocationScene)

	if location_scene != null and location_scene.location_id == location_id:

		return location_scene

	var path = "res://world/locations/%s.scn" % location_id

	if FileAccess.file_exists(path):

		location_scene = load(path).instantiate()

	return location_scene







## Private

func _load_scene(scene_script: Script) -> GameScene:

	for scene in get_tree().get_nodes_in_group("game_scene"):

		scene._deactivate()

	var scene: GameScene = null

	if scene_registry.has(scene_script):

		scene = scene_registry[scene_script]

	if scene != null:

		if active_scene:

			active_scene._deactivate()

		scene._activate()

	return scene