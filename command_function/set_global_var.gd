class_name SetGlobalVar extends CommandFunction


@export var variable: StringName

@export var value: Variant






func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	Globals.set_var(variable, value)

	return true