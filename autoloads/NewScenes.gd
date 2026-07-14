extends Node




var active_scene: NewGameScene

var scene_registry: Dictionary[Script, NewGameScene]
















func activate_scene(scene_script: Script) -> NewGameScene:

	assert(scene_registry.has(scene_script), "Missing scene for script: %s" % scene_script)

	if active_scene:

		active_scene._deactivate()

	active_scene = scene_registry[scene_script]

	active_scene._activate()

	return active_scene





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





func load_location_scene(location_id: StringName) -> NewLocationScene:

	var path = "res://world/locations/%s.scn" % location_id

	if FileAccess.file_exists(path):

		return load(path).instantiate() as NewLocationScene

	return null