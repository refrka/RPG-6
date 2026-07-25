class_name WanderBehavior extends Behavior


@export var wander_speed:= 15.0

@export var wander_range:= Vector2(50.0, 100.0)

@export var idle_duration_range:= Vector2(2.0, 4.0)


var movement_component: MovementComponent

var navigation_component: NavigationComponent

var idle_timer:= 0.0

var wander_target: Vector2





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	navigation_component = entity.get_component(NavigationComponent)

	movement_component = entity.get_component(MovementComponent)

	entity.nav_agent.target_reached.connect(_on_target_reached)





func _start() -> void:

	movement_component.set_move_speed_override(wander_speed)

	_start_wander()




func _end() -> void:

	movement_component.remove_move_speed_override()

	idle_timer = 0.0

	navigation_component.halt()




func _start_wander() -> void:

	idle_timer = 0.0

	var target_pos:= Vector2(INF, INF)

	navigation_component.set_target_pos(target_pos)

	while !entity.nav_agent.is_target_reachable():

		var x_range = Vector2(-wander_range.x, wander_range.x)

		var x_pos = randf_range(x_range.x, x_range.y)

		var y_range = Vector2(-wander_range.y, wander_range.y)

		var y_pos = randf_range(y_range.x, y_range.y)

		target_pos = entity.global_position + Vector2(x_pos, y_pos)

		navigation_component.set_target_pos(target_pos)

		await Scenes.get_tree().process_frame

	wander_target = entity.nav_agent.get_final_position()





func _start_idle() -> void:

	navigation_component.halt()

	var duration = randf_range(idle_duration_range.x, idle_duration_range.y)

	idle_timer = duration






func _on_target_reached() -> void:

	_start_idle()






func _tick(delta: float) -> void:

	if idle_timer > 0.0:

		idle_timer -= delta

		if idle_timer <= 0.0:

			_start_wander()





