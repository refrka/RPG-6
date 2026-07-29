class_name SetPlayerSpawnPointCommand extends Command


@export var spawn_id: StringName



func execute(_data: Dictionary = {}) -> bool:

	if _data.has("spawn_id"):

		spawn_id = _data["spawn_id"]

	var location = Scenes.get_world_scene().get_active_location()

	var spawn_point = location.get_spawn_point(spawn_id)

	var player = Game.get_player()

	player.active_spawn_point = spawn_point

	Events.fire(PlayerSpawnPointSetEvent, {"spawn_point": spawn_point}, true)

	return super()




static func run(_data: Dictionary = {}) -> bool:

	var command = SetPlayerSpawnPointCommand.new()

	return command.execute(_data)