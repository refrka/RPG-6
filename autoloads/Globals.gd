extends Node



var flags: Dictionary[StringName, bool]

var vars: Dictionary[StringName, Variant]





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS



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








func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["flags"] = flags

	save_dict["vars"] = vars

	return save_dict




func load_dictionary(save_dict: Dictionary) -> void:

	flags.assign(save_dict["flags"])

	vars.assign(save_dict["vars"])