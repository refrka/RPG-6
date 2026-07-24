class_name SaveData extends Resource



var save_id: String

var save_name: String

var last_dict: Dictionary








func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	save_dict["player"] = Game.get_player()._get_dictionary()

	# get_dicitonary() will call many other sources' get_dictionary() methods to collect all the data

	# there must be a matching load_dictionary() counterpart called together (load_dictionary(), below)

	# Each of these sources needs to sync with the game ending to clear their data cache

	return save_dict






func load_dictionary() -> void:

	# Dispense data from last_dict into the game

	pass







static func create(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	save_data.last_dict = save_dict

	return save_data