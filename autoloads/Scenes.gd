extends Node




var scene_registry:= {}


var active_scene: GameScene





func _ready() -> void:

	pass






## Top-level Scene Methods


func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene







func load_scene(scene_script: Script) -> GameScene:

	var scene = _load_scene(scene_script)

	return scene





func get_scene(scene_script: Script) -> GameScene:

	if scene_registry.has(scene_script):

		return scene_registry[scene_script]

	return null













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