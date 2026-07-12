class_name CommandFunction extends Resource


@warning_ignore("unused_signal")

signal command_executed


var data: Dictionary



func execute(_data: Dictionary = {}) -> bool:

	data = _data

	return true