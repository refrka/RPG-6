class_name SaveData extends Resource



var save_id: String

var save_name: String

var location_id: StringName

var spawn_id: StringName

var last_dict: Dictionary

var inventory: Inventory


var location_data_list: Array[LocationData]

var entity_data_list: Array[EntityData]

var quest_data_list: Array[QuestData]





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




func get_quest_data(quest_id: StringName) -> QuestData:

	for quest_data in quest_data_list:

		if quest_data.quest_id == quest_id:

			return quest_data

	return null





func get_dictionary() -> Dictionary:
	
	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	save_dict["location_id"] = location_id

	save_dict["spawn_id"] = spawn_id

	save_dict["inventory"] = inventory.get_dictionary()

	for location_data in location_data_list:

		save_dict["location_data"].append(location_data.get_dictionary())
	
	for entity_data in entity_data_list:

		save_dict["entity_data"].append(entity_data._get_dictionary())

	for quest_data in quest_data_list:

		save_dict["quest_data"].append(quest_data.get_dictionary())

	last_dict = save_dict

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.last_dict = save_dict

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	save_data.location_id = save_dict["location_id"]

	save_data.spawn_id = save_dict["spawn_id"]

	save_data.inventory = Inventory.load_dictionary(save_dict["inventory"])

	for dict in save_dict["location_data"]:

		var location_data = LocationData.load_dictionary(dict)

		save_data.location_data_list.append(location_data)

	for dict in save_dict["entity_data"]:

		var entity_data = EntityData.load_dictionary(dict)
		
		save_data.entity_data_list.append(entity_data)

	if !save_dict.has("quest_data"):

		save_dict["quest_data"] = []

	for dict in save_dict["quest_data"]:

		var quest_data = QuestData.load_dictionary(dict)

		save_data.quest_data_list.append(quest_data)

	return save_data