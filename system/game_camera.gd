class_name GameCamera extends Camera2D



var following_player:= false


var camera_limit_top_left: Marker2D

var camera_limit_bottom_right: Marker2D


func _ready() -> void:

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

	anchor_mode = ANCHOR_MODE_DRAG_CENTER

	following_player = true

	var player = Game.get_player()

	reparent(player)

	global_position = player.global_position




func unfollow_player() -> void:

	anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT

	following_player = false

	var game_root = Game.get_game_root()

	reparent(game_root)

	global_position = camera_limit_top_left.global_position





func reset_on_location(location: Location) -> void:

	camera_limit_top_left = location.camera_limit_top_left

	camera_limit_bottom_right = location.camera_limit_bottom_right

	anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT

	global_position = camera_limit_top_left.global_position





func _on_player_entered_location(event: Event) -> void:

	var location = event.data["location"]

	camera_limit_top_left = location.camera_limit_top_left
	
	camera_limit_bottom_right = location.camera_limit_bottom_right

	if location.camera_follow_player:

		if !following_player:

			follow_player()

			set_camera_limits()

	else:

		if following_player:

			unfollow_player()

	



func _on_game_ending(_event: Event) -> void:

	if following_player:

		unfollow_player()