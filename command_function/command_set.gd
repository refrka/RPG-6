class_name CommandSet extends Resource


signal all_commands_executed


@export var command_functions: Array[CommandFunction]


var command_index:= 0

var data: Dictionary


func execute(_data: Dictionary = {}) -> void:

	data = _data

	var command = command_functions[command_index]

	command.command_executed.connect(_on_command_executed)

	command.execute(data)






func _on_command_executed() -> void:

	command_index += 1

	if command_index <= command_functions.size() - 1:

		execute(data)

	else:

		all_commands_executed.emit()