class_name Cutscene extends GameScene

signal cutscene_ended


var active_cutscene_script: CutsceneScript


var cutscene_data: Dictionary

var cutscene_location: Location

var paused_location: Location



func run_cutscene_script(cutscene_script: CutsceneScript, data: Dictionary) -> void:

	active_cutscene_script = cutscene_script

	active_cutscene_script.cutscene_ended.connect(_on_cutscene_ended)

	cutscene_data = data

	# Location handling

	var world_scene = Scenes.get_world_scene()

	var current_location = world_scene.get_active_location()

	if current_location:

		world_scene.pause_location(current_location)

		paused_location = current_location

	cutscene_location = Scenes.get_location(active_cutscene_script.location_id)

	add_child(cutscene_location)

	cutscene_location._initialize()

	active_cutscene_script.cutscene_location = cutscene_location

	#	

	active_cutscene_script._initialize()

	active_cutscene_script._start()






func _on_cutscene_ended() -> void:

	active_cutscene_script = null

	cutscene_data = {}

	cutscene_location.queue_free()

	cutscene_location = null

	var world_scene = Scenes.activate_scene(WorldScene)

	if paused_location:

		print("unpause and activate")

		world_scene.unpause_location(paused_location, true)

	paused_location = null

	cutscene_ended.emit()