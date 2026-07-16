class_name StartCutscene extends Command


@export var cutscene: Cutscene




func execute(_data: Dictionary = {}) -> bool:

	print("start it")

	Scenes.start_cutscene(cutscene)

	return true