class_name NavigationComponent extends Component


signal target_pos_reached

signal target_pos_updated


var movement_component: MovementComponent



var next_path_position: Vector2

var target_pos: Vector2

var target_entity: EntityNode

var track_timer: Timer





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	process_mode = Node.PROCESS_MODE_PAUSABLE

	if entity is PlayerNode:

		_deactivate()

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.target_reached.connect(_on_target_reached)

	Events.subscribe(GameEndingEvent, _on_game_ending)

	Events.subscribe(GamePausedEvent, _on_game_pause_state_changed.bind(true))

	Events.subscribe(GameResumedEvent, _on_game_pause_state_changed.bind(false))






func set_target_pos(new_pos: Vector2) -> void:

	print("setting pos %s for %s" % [new_pos, entity.get_display_name()])

	if target_pos == new_pos:

		return

	target_pos = new_pos

	movement_component.set_face_dir(entity.global_position.direction_to(target_pos))

	entity.nav_agent.set_target_position(target_pos)





func set_target_entity(entity_node: EntityNode) -> void:

	target_entity = entity_node

	set_target_pos(target_entity.global_position)

	_set_track_timer()




func set_target_desired_distance(distance: float) -> void:

	entity.nav_agent.target_desired_distance = distance



func reset_target_desired_distance() -> void:

	entity.nav_agent.target_desired_distance = 8.0





func clear_target_entity() -> void:

	target_entity = null




func halt() -> void:

	movement_component.halt()










func _set_track_timer() -> void:

	if track_timer == null:

		track_timer = Timer.new()

		add_child(track_timer)

		track_timer.timeout.connect(_on_track_timer_timeout)

		track_timer.start(0.25)







func _on_target_reached() -> void:

	target_pos_reached.emit()

	halt()




func _on_track_timer_timeout() -> void:

	if is_instance_valid(target_entity):

		set_target_pos(target_entity.global_position)

		_set_track_timer()




func _on_game_ending(_event: Event) -> void:

	if track_timer:

		track_timer.stop()

		track_timer.queue_free()

	entity.nav_agent.target_position = entity.global_position





func _on_game_pause_state_changed(_event: Event, state: bool) -> void:

	if track_timer:

		track_timer.paused = state











func _activate() -> void:

	if entity is PlayerNode:

		return

	super()


	




func _process(_delta: float) -> void:

	if !active:

		return

	if entity.nav_agent.is_navigation_finished():

		return

	var new_next_path_position = entity.nav_agent.get_next_path_position()

	if new_next_path_position != next_path_position:

		next_path_position = new_next_path_position

		var move_dir = entity.global_position.direction_to(next_path_position)

		movement_component.set_move_dir(move_dir)

		target_pos_updated.emit()






