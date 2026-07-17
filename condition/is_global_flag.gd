class_name IsGlobalFlag extends Condition


@export var flag: StringName

@export var state: bool




func evaluate(_data: Dictionary = {}) -> bool:

	return Globals.get_flag(flag) == state