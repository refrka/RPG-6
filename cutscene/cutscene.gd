class_name Cutscene extends Resource


signal finished


@export var location_id: StringName


var paused_location_id: StringName

var paused_position: Vector2





func _start() -> void:

	pass









func _end() -> void:

	finished.emit()