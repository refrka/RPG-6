class_name CommandSet extends Resource




@export var command_functions: Array[CommandFunction]





func execute(_data: Dictionary = {}) -> void:

	for command in command_functions:

		command.execute(_data)