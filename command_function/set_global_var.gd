class_name SetGlobalVar extends CommandFunction


@export var variable: StringName

@export var value: Variant






func execute(_data: Dictionary = {}) -> bool:

	Globals.set_var(variable, value)

	return true