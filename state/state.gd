class_name State extends Node







var entity: EntityNode






func _setup(_entity: EntityNode) -> void:

	entity = _entity













func get_state_name() -> StringName:

	return name.trim_suffix("State").to_snake_case()




func _enter() -> void:

	pass


func _exit() -> void:

	pass



func _tick(_delta: float) -> void:

	pass