class_name IsGlobalVar extends Condition


@export var var_name: StringName

@export var value: Variant




func evaluate(_data: Dictionary = {}) -> bool:

	return Globals.get_var(var_name) == value