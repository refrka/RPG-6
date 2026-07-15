class_name SaveData extends Resource



var save_id: String

var save_name: String

var last_dict: Dictionary

var location_data_list: Array[LocationData]

var entity_data_registry: Dictionary[StringName, EntityData]





func get_last_location_id() -> StringName:

	return last_dict["location_id"]



func get_last_spawn_id() -> StringName:

	return last_dict["spawn_id"]



func add_location_data(location_data: LocationData) -> void:

	if !location_data_list.has(location_data):

		location_data_list.append(location_data)





























func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	last_dict = save_dict

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	save_data.last_dict = save_dict

	return save_data