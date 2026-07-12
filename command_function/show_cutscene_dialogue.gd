class_name ShowCutsceneDialogue extends CommandFunction


@export var cutscene_dialogue: CutsceneDialogue




func execute(_data: Dictionary = {}) -> bool:

	var interaction_overlay = UI.open_interaction_overlay()

	interaction_overlay.show_cutscene_dialogue(cutscene_dialogue)

	interaction_overlay.close_requested.connect(_on_close_requested)

	return true






func _on_close_requested() -> void:

	command_executed.emit()