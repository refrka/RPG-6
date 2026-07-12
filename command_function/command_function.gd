class_name CommandFunction extends Resource


signal command_executed


var data: Dictionary



func execute(_data: Dictionary = {}) -> bool:

	data = _data

	command_executed.emit()

	return true