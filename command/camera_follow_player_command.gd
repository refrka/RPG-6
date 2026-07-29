class_name CameraFollowPlayerCommand extends Command




func execute(_data: Dictionary = {}) -> bool:

	var camera = Game.get_camera()

	camera.follow_player()

	return true




static func run(_data: Dictionary = {}) -> bool:

	var command = CameraFollowPlayerCommand.new()

	return command.execute(_data)