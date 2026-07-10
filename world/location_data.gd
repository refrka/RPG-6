class_name LocationData extends Resource


var discovered:= false

var location_id: StringName

var location_scene: LocationScene

var container_states: Array[bool]








func update_container_state(index: int, state: bool) -> void:

	container_states[index] = state






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["location_id"] = location_id

	save_dict["discovered"] = discovered

	save_dict["container_states"] = container_states

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> LocationData:

	var location_data = LocationData.new()

	location_data.location_id = save_dict["location_id"]

	location_data.discovered = save_dict["discovered"]

	location_data.container_states.assign(save_dict["container_states"])

	return location_data