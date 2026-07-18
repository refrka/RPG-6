class_name State extends Node







var entity: EntityNode






func _setup(_entity: EntityNode) -> void:

	entity = _entity













func get_state_script() -> Script:

	return get_script()




func _enter() -> void:

	pass


func _exit() -> void:

	pass



func _tick(_delta: float) -> void:

	pass