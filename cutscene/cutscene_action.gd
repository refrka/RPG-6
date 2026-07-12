class_name CutsceneAction extends Resource


signal action_completed


@export var command_set: CommandSet






func execute() -> void:

	command_set.all_commands_executed.connect(_on_all_commands_executed, CONNECT_ONE_SHOT)

	command_set.execute()





func _on_all_commands_executed() -> void:

	action_completed.emit()