class_name CommandSet extends Resource




@export var commands: Array[Command]

var data: Dictionary



func execute(_data: Dictionary = {}) -> bool:

	data = _data

	for command in commands:

		if command.execute(data):

			continue

		else:

			await command.executed

	return true