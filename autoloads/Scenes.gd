extends Node



signal cutscene_ended(cutscene: Cutscene)




var scene_registry:= {}

var active_scene: GameScene

var active_cutscene: Cutscene

var location_paths: Array[String]





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	Events.subscribe(GameEndingEvent, _on_game_ending)

	_load_locations()






func activate_scene(scene_script: Script) -> GameScene:

	if !scene_registry.has(scene_script):

		return null

	var new_scene = scene_registry[scene_script]

	for scene in scene_registry.values():

		if scene == new_scene:

			scene._activate()

		else:

			scene._deactivate()

	return new_scene





func load_location(location_id: StringName) -> Location:

	var world_scene = get_world_scene()

	var location = world_scene.activate_location(location_id, true)

	return location





func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene





func get_location(location_id: StringName) -> Location:

	var all_locations = get_world_scene().get_all_locations()

	for location in all_locations:

		if location.location_id == location_id:

			return location

	return get_location_scene(location_id)





func get_location_scene(location_id: StringName = "") -> Location:

	if location_id == &"":

		return get_world_scene().get_active_location()
	
	var file_name = "%s.scn" % location_id

	for path in location_paths:

		if path.ends_with(file_name):

			return load(path).instantiate() as Location

	return null






func get_world_scene() -> WorldScene:

	if scene_registry.has(WorldScene):

		return scene_registry[WorldScene]

	return null




func get_cutscene() -> Cutscene:

	return scene_registry[Cutscene]




func run_cutscene(cutscene_script_name: Script, data:= {}) -> Cutscene:

	var cutscene = Scenes.activate_scene(Cutscene)

	cutscene.run_cutscene_script(cutscene_script_name.new(), data)

	return cutscene










func _load_scene(scene_script: Script) -> GameScene:

	var scene: GameScene = null

	if scene_registry.has(scene_script):

		scene = scene_registry[scene_script]

	if scene != null:

		if active_scene:

			active_scene._deactivate()

		scene._activate()

	return scene





func _load_locations() -> void:

	var sub_dirs = ["res://world/locations/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir

			if dir.ends_with(".scn"):

				location_paths.append(path)

			elif dir.ends_with("/"):

				sub_dirs.append(path)
















func _on_cutscene_ended(cutscene: Cutscene) -> void:

	cutscene_ended.emit(cutscene)


func _on_game_ending(_event: Event) -> void:

	activate_scene(MainMenu)