class_name NewGameCutscene extends CutsceneScript



func _initialize() -> void:

	location_id = "forest_start"





func _start() -> void:

	var entity_def = Entities.get_entity_def_by_unique_id("mim")

	var entity_node = Entities.create_entity_node(entity_def)

	await Game.get_timer(3.0).timeout

	_end()