class_name NewGameCutscene extends Cutscene




@export var command: Command





func _start() -> void:

	var world_scene = Scenes.get_scene(WorldScene)

	var location_scene = world_scene.load_location(location_id)

	var entity_node = location_scene.character_root.find_child("Mim")

	command.execute({"entity_node": entity_node, "target_pos": entity_node.global_position + Vector2(0, 100)})

	await Scenes.start_timer(3.0).timeout

	_end()

