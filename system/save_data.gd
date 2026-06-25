class_name SaveData extends Resource



var save_id: String







func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_data").new().data

	save_dict["save_id"] = save_id

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.save_id = save_dict["save_id"]

	return save_data