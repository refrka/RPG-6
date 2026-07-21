extends Node



var default_flags: Dictionary[StringName, int] = {

	&"new_game_cutscene_complete": 0,

}


var default_vars: Dictionary[StringName, Variant] = {  }

var flags: Dictionary[StringName, int]

var vars: Dictionary[StringName, Variant]










func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	Events.subscribe(GameEndedEvent, _on_game_ended)

	_reset_globals()











func set_flag(flag: StringName, value: bool) -> void:

	flags[flag] = int(value)



func set_var(var_name: StringName, value: Variant) -> void:

	vars[var_name] = value



func get_flag(flag: StringName) -> bool:

	if flags.has(flag):

		return bool(flags[flag])

	return false



func get_var(var_name: StringName) -> Variant:

	if vars.has(var_name):

		return vars[var_name]

	return null








func _reset_globals() -> void:

	flags = default_flags.duplicate()

	vars = default_vars.duplicate()







func _on_game_ended(_event: Event) -> void:

	flags = {}

	vars = {}












func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["flags"] = flags

	save_dict["vars"] = vars

	return save_dict




func load_dictionary(save_dict: Dictionary) -> void:

	flags = {}

	vars = {}

	flags.assign(save_dict["flags"])

	vars.assign(save_dict["vars"])





