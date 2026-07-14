extends Node




var scene_registry:= {}


var active_scene: GameScene





func _ready() -> void:

	pass






func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene




func unregister_scene(scene: GameScene) -> void:

	scene_registry.erase(scene.get_script())




func activate_scene(scene: GameScene) -> void:

	if active_scene:

		active_scene._deactivate()

	active_scene = scene

	scene._activate()





func get_scene(scene_script: Script) -> GameScene:

	if !scene_registry.has(scene_script):

		for script in scene_registry:

			if script.get_base_script() == scene_script:

				return script
		
		return null

	return scene_registry[scene_script]







func _load_scene(scene_script: Script) -> GameScene:

	var scene: GameScene = null

	if scene_registry.has(scene_script):

		scene = scene_registry[scene_script]

	if scene != null:

		if active_scene:

			active_scene._deactivate()

		scene._activate()

	return scene