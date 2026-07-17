class_name Cutscene extends Resource


signal finished


@export var location_id: StringName

var paused_location_id: StringName

var paused_position: Vector2





func _start() -> void:

	pass









func _end() -> void:

	var flag = get_script().get_global_name().to_snake_case()

	Globals.set_flag(flag, true)

	finished.emit()