class_name Trigger extends Resource



signal triggered






func _initialize() -> void:

	pass



func _unload() -> void:

	pass



func _trigger() -> void:

	triggered.emit()