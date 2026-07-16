extends Node



var flags: Dictionary[StringName, bool]

var vars: Dictionary[StringName, Variant]






func set_flag(flag: StringName, value: bool) -> void:

	flags[flag] = value





func set_var(var_name: StringName, value: Variant) -> void:

	vars[var_name] = value





func get_flag(flag: StringName) -> bool:

	if flags.has(flag):

		return flags[flag]

	return false




func get_var(var_name: StringName) -> Variant:

	if vars.has(var_name):

		return vars[var_name]

	return null




