class_name Sensor extends Area2D


var bodies: Array[PhysicsBody2D]

var areas: Array[Area2D]






var active:= true

var entity: EntityNode






func setup(_entity: EntityNode = null) -> void:

	activate()

	entity = _entity








func activate() -> void:

	active = true

	_connect_signals()






func deactivate() -> void:

	active = false

	bodies.clear()

	areas.clear()

	_disconnect_signals()







func get_nearest_body() -> PhysicsBody2D:

	var nearest_body: PhysicsBody2D = null

	var nearest_distance:= INF

	for body in bodies:

		var distance = body.global_position.distance_to(entity.global_position)

		if !nearest_body or distance < nearest_distance:

			nearest_body = body

			nearest_distance = distance

	return nearest_body






func _connect_signals() -> void:

	if !body_entered.is_connected(_on_body_entered):

		body_entered.connect(_on_body_entered)

	if !body_exited.is_connected(_on_body_exited):

		body_exited.connect(_on_body_exited)

	if !area_entered.is_connected(_on_area_entered):

		area_entered.connect(_on_area_entered)

	if !area_exited.is_connected(_on_area_exited):

		area_exited.connect(_on_area_exited)





func _disconnect_signals() -> void:

	if body_entered.is_connected(_on_body_entered):

		body_entered.disconnect(_on_body_entered)

	if body_exited.is_connected(_on_body_exited):

		body_exited.disconnect(_on_body_exited)

	if area_entered.is_connected(_on_area_entered):

		area_entered.disconnect(_on_area_entered)

	if area_exited.is_connected(_on_area_exited):

		area_exited.disconnect(_on_area_exited)







func _on_body_entered(body: PhysicsBody2D) -> void:

	if body == entity:

		return

	if !bodies.has(body):

		bodies.append(body)




func _on_body_exited(body: PhysicsBody2D) -> void:

	if bodies.has(body):

		bodies.erase(body)




func _on_area_entered(area: Area2D) -> void:

	if area is Sensor and area.entity == entity:

		return

	if !areas.has(area):

		areas.append(area)




func _on_area_exited(area: Area2D) -> void:

	if areas.has(area):

		areas.erase(area)