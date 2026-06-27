class_name SaveData extends Resource



var save_id: String

var save_name: String

var location_id: StringName

var spawn_id: StringName

var last_dict: Dictionary



var location_data_list: Array[LocationData]

var entity_data_list: Array[EntityData]





func get_location_data(_location_id: StringName) -> LocationData:

	for location_data in location_data_list:

		if location_data.location_id == _location_id:

			return location_data

	return null





func get_entity_data(unique_id: StringName) -> EntityData:

	for entity_data in entity_data_list:

		if entity_data.def.unique_id == unique_id:

			return entity_data

	return null





func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	save_dict["location_id"] = location_id

	save_dict["spawn_id"] = spawn_id

	for location_data in location_data_list:

		save_dict["location_data"].append(location_data.get_dictionary())
	
	for entity_data in entity_data_list:

		save_dict["entity_data"].append(entity_data.get_dictionary())

	last_dict = save_dict

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.last_dict = save_dict

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	save_data.location_id = save_dict["location_id"]

	save_data.spawn_id = save_dict["spawn_id"]

	for dict in save_dict["location_data"]:

		var location_data = LocationData.load_dictionary(dict)

		save_data.location_data_list.append(location_data)

	for dict in save_dict["entity_data"]:

		var entity_data = EntityData.load_dictionary(dict)

		var def = Entities.get_def(dict["entity_id"])
		
		entity_data.def = def
		
		save_data.entity_data_list.append(entity_data)

	return save_data