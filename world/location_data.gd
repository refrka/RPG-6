class_name LocationData extends Resource


var location_id: StringName


var location_scene: LocationScene




















func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["location_id"] = location_id

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> LocationData:

	var location_data = LocationData.new()

	location_data.location_id = save_dict["location_id"]

	return location_data