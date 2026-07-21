class_name NewGameCutscene extends CutsceneScript



func _initialize() -> void:

	location_id = "forest_area_1"





func _start() -> void:

	await Game.get_timer(3.0).timeout

	_end()