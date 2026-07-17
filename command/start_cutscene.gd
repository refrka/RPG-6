class_name StartCutscene extends Command


@export var cutscene: Cutscene




func execute(_data: Dictionary = {}) -> bool:

	Scenes.start_cutscene(cutscene)

	return true