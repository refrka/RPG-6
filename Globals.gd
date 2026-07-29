extends Node



var default_flags: Dictionary[StringName, int] = {

	&"new_game_cutscene_complete": 0,

}


var default_vars: Dictionary[StringName, Variant] = { 


}


var default_lists: Dictionary[StringName, Array] = {

	"discovered_locations": [ ],

	"greeted_characters": [ ],

}



var flags: Dictionary[StringName, int]

var vars: Dictionary[StringName, Variant]

var lists: Dictionary[StringName, Array]








func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	Events.subscribe(GameEndedEvent, _on_game_ended)

	_reset_globals()











func set_flag(flag: StringName, value: bool) -> void:

	flags[flag] = int(value)



func set_var(var_name: StringName, value: Variant) -> void:

	vars[var_name] = value



func add_to_list(list_name: StringName, value: Variant) -> void:

	if !lists[list_name].has(value):

		lists[list_name].append(value)



func get_flag(flag: StringName) -> bool:

	if flags.has(flag):

		return bool(flags[flag])

	return false



func get_var(var_name: StringName) -> Variant:

	if vars.has(var_name):

		return vars[var_name]

	return null



func is_in_list(list_name: StringName, value: Variant) -> bool:

	return lists[list_name].has(value)





func _reset_globals() -> void:

	flags = default_flags.duplicate()

	vars = default_vars.duplicate()

	lists = default_lists.duplicate()







func _on_game_ended(_event: Event) -> void:

	_reset_globals()












func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["flags"] = flags

	save_dict["vars"] = vars

	save_dict["lists"] = lists

	return save_dict




func load_dictionary(save_dict: Dictionary) -> void:

	flags = {}

	vars = {}

	lists = {}

	flags.assign(save_dict["flags"])

	vars.assign(save_dict["vars"])





