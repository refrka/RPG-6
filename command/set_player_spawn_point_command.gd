class_name SetPlayerSpawnPointCommand extends Command


@export var spawn_id: StringName

@export var location_id: StringName



func execute(_data: Dictionary = {}) -> bool:

	var spawn_point: SpawnPoint = null

	var location: Location = null

	if _data.has("location"):

		location = _data["location"]

	else:

		if _data.has("location_id"):

			location_id = _data["location_id"]

		location = Scenes.get_location_scene(location_id)

	if _data.has("spawn_point"):

		spawn_point = _data["spawn_point"]

	else:

		if _data.has("spawn_id"):

			spawn_id = _data["spawn_id"]

		spawn_point = location.get_spawn_point(spawn_id)

	var player = Game.get_player()

	player.active_location = location

	player.active_spawn_id = spawn_point.spawn_id

	Events.fire(PlayerSpawnPointSetEvent, {"spawn_point": spawn_point, "location": location}, true)

	return super()




static func run(_data: Dictionary = {}) -> bool:

	var command = SetPlayerSpawnPointCommand.new()

	return command.execute(_data)