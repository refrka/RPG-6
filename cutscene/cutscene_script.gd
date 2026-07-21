class_name CutsceneScript extends Resource


signal cutscene_ended


@export var location_id: StringName






func _initialize() -> void:

	pass





func _start() -> void:

	pass




func _end() -> void:

	cutscene_ended.emit()