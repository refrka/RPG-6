class_name SaveData extends Resource



var save_id: String

var save_name: String





func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	return save_data