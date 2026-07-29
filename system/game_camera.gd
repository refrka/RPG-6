class_name GameCamera extends Camera2D



var following_player:= false


var camera_limit_top_left: Marker2D

var camera_limit_bottom_right: Marker2D


func _ready() -> void:

	Events.subscribe(GameStartedEvent, _on_game_started)

	Events.subscribe(PlayerEnteredLocationEvent, _on_player_entered_location)

	Events.subscribe(GameEndingEvent, _on_game_ending)




func set_camera_limits() -> void:

	var top_left_pos = camera_limit_top_left.global_position

	var bottom_right_pos = camera_limit_bottom_right.global_position

	limit_left = top_left_pos.x

	limit_top = top_left_pos.y

	limit_right = bottom_right_pos.x

	limit_bottom = bottom_right_pos.y





func follow_player() -> void:

	following_player = true

	anchor_mode = ANCHOR_MODE_DRAG_CENTER

	var player = Game.get_player()

	position = Vector2.ZERO + player.global_position

	reparent(player)




func unfollow_player() -> void:

	following_player = false

	var game_root = Game.get_game_root()

	reparent(game_root)

	position = Vector2.ZERO

	anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT





func reset_on_location(location: Location) -> void:

	camera_limit_top_left = location.camera_limit_top_left

	camera_limit_bottom_right = location.camera_limit_bottom_right

	position = Vector2.ZERO

	set_camera_limits()





func _on_player_entered_location(event: Event) -> void:

	var location = event.data["location"]

	reset_on_location(location)

	if location.camera_follow_player:

		if !following_player:

			CameraFollowPlayerCommand.run()

	else:

		if following_player:

			CameraUnfollowPlayerCommand.run()





func _on_game_started(_event: Event) -> void:

	var active_location = Scenes.get_world_scene().get_active_location()

	if active_location.camera_follow_player:

		CameraFollowPlayerCommand.run()

	



func _on_game_ending(_event: Event) -> void:

	if following_player:

		CameraUnfollowPlayerCommand.run()

