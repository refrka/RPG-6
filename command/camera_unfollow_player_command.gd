class_name CameraUnfollowPlayerCommand extends Command




func execute(_data: Dictionary = {}) -> bool:

	var camera = Game.get_camera()

	camera.unfollow_player()

	return true




static func run(_data: Dictionary = {}) -> bool:

	var command = CameraUnfollowPlayerCommand.new()

	return command.execute(_data)