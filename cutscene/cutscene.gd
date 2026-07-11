class_name Cutscene extends Resource



@export var cutscene_id: StringName

@export var location_id: StringName










func start() -> void:

	var location_scene = Scenes.get_scene(LocationScene)

	if location_scene.location_id != location_id:

		Game.load_location(location_id)










