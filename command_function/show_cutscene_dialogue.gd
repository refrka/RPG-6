class_name ShowCutsceneDialogue extends CommandFunction


@export var cutscene_dialogue: CutsceneDialogue




func execute(_data: Dictionary = {}) -> bool:

	var overlay = UI.open_interaction_overlay()

	overlay.close_requested.connect(_on_close_requested)

	return true






func _on_close_requested() -> void:

	command_executed.emit()