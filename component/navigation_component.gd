class_name NavigationComponent extends Component


signal target_pos_reached

signal target_pos_updated


var movement_component: MovementComponent



var next_path_position: Vector2

var target_pos: Vector2

var target_entity: EntityNode

var track_timer: SceneTreeTimer





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if entity is PlayerNode:

		_deactivate()

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.target_reached.connect(_on_target_reached)







func set_target_pos(new_pos: Vector2) -> void:

	if target_pos == new_pos:

		return

	target_pos = new_pos

	movement_component.set_face_dir(entity.global_position.direction_to(target_pos))

	entity.nav_agent.set_target_position(target_pos)





func set_target_entity(entity_node: EntityNode) -> void:

	target_entity = entity_node

	set_target_pos(target_entity.global_position)

	_set_track_timer()





func clear_target_entity() -> void:

	target_entity = null




func halt() -> void:

	movement_component.halt()

	set_target_pos(entity.global_position)










func _set_track_timer() -> void:

	track_timer = Game.get_timer(0.5)

	track_timer.timeout.connect(_on_track_timer_timeout)




func _clear_track_timer() -> void:

	if track_timer:

		track_timer.timeout.disconnect(_on_track_timer_timeout)





func _on_target_reached() -> void:

	target_pos_reached.emit()

	halt()




func _on_track_timer_timeout() -> void:

	track_timer = null

	if is_instance_valid(target_entity):

		set_target_pos(target_entity.global_position)

		_set_track_timer()





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





