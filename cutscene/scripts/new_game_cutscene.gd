class_name NewGameCutscene extends CutsceneScript



func _initialize() -> void:

	location_id = "forest_start"





func _start() -> void:

	var entity = Scenes.get_cutscene().cutscene_location.character_root.get_children()[1]

	var nav_comp = entity.get_component(NavigationComponent)

	nav_comp.set_target_pos(entity.global_position + Vector2(50,0))

	await Game.get_timer(3.0).timeout

	_end()