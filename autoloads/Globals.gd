extends Node



var global_vars:= {}







func set_var(variable: StringName, value: Variant) -> void:

	global_vars.set(variable, value)



func get_var(variable: StringName) -> Variant:

	return global_vars.get(variable)