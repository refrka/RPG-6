class_name SaveDataInstance extends Resource





var uid: int



func _init() -> void:

	_generate_uid()

	



func get_uid() -> int:

	return uid



func _generate_uid() -> void:

	uid = randi()