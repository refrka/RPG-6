class_name CommandSet extends Resource




var commands: Array[Command]

var data: Dictionary



func execute(_data: Dictionary) -> bool:

	data = _data

	var all_executed = true

	for command in commands:

		if !command.execute(data):

			all_executed = false

	return all_executed