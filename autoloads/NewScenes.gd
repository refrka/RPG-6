extends Node




var active_scene: NewGameScene

var scene_registry: Dictionary[Script, NewGameScene]
















func activate_scene(scene: NewGameScene) -> void:

	if active_scene:

		active_scene._deactivate()

	active_scene = scene

	active_scene._activate()





func register_scene(scene: NewGameScene) -> void:

	scene_registry[scene.get_script()] = scene




func unregister_scene(scene: NewGameScene) -> void:

	assert(scene_registry.has(scene.get_script()))

	scene_registry.erase(scene.get_script())





func get_scene(scene_script: Script = null) -> NewGameScene:

	if scene_script == null:

		return active_scene

	assert(scene_registry.has(scene_script), "Scene script not found in registry: %s" % scene_script)

	return scene_registry[scene_script]