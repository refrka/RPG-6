extends Node




var scene_registry:= {}


var active_scene: GameScene





func _ready() -> void:

	pass







func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene










func _load_scene(scene_script: Script) -> GameScene:

	var scene: GameScene = null

	if scene_registry.has(scene_script):

		scene = scene_registry[scene_script]

	if scene != null:

		if active_scene:

			active_scene._deactivate()

		scene._activate()

	return scene