extends Node




var scene_registry:= {}

var active_scene: GameScene

var location_paths: Array[String]



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_load_locations()





func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene




func get_location(location_id: StringName) -> Location:

	var all_locations = get_world_scene().get_all_locations()

	for location in all_locations:

		if location.location_id == location_id:

			return location

	var file_name = "%s.scn" % location_id

	for path in location_paths:

		if path.ends_with(file_name):

			return load(path).instantiate() as Location

	return null




func get_world_scene() -> WorldScene:

	if scene_registry.has(WorldScene):

		return scene_registry[WorldScene]

	return null





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
