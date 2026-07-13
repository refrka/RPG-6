extends Node




var modulate_rect: ModulateRect

var cutscene_list: Dictionary[StringName, Cutscene]

var scene_registry:= {}

var active_scene: GameScene





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	modulate_rect = get_tree().get_first_node_in_group("modulate_rect")

	_load_cutscenes()






## Top-level Scene Methods


func register_scene(scene: GameScene) -> void:

	scene_registry[scene.get_script()] = scene





func start_cutscene(cutscene_id: StringName) -> Cutscene:

	var player = Game.get_player()

	player._disable()

	var cutscene = _get_cutscene(cutscene_id)

	if !cutscene:

		return null

	cutscene.cutscene_finished.connect(_on_cutscene_finished)

	cutscene.start()

	return cutscene





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







func fade_modulate_rect(out:= true, color:= Color.BLACK) -> void:

	if out:

		modulate_rect.fade_out(color)

	else:

		modulate_rect.fade_in()






func _set_modulate_rect(modulate: Color, fade:= false) -> void:

	if fade:

		return

	modulate_rect.modulate = modulate





func _get_cutscene(cutscene_id: StringName) -> Cutscene:

	if !cutscene_list.has(cutscene_id):

		return null

	return cutscene_list[cutscene_id]






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






func _load_cutscenes() -> void:

	var sub_dirs = ["res://cutscene/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for file_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + file_name

			if path.ends_with(".tres"):

				var cutscene = load(path) as Cutscene

				cutscene_list[cutscene.cutscene_id] = cutscene

			elif path.ends_with("/"):

				sub_dirs.append(path)







func _on_cutscene_finished() -> void:

	pass