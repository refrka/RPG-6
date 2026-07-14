class_name NewSaveData extends Resource




var instances: Dictionary[int, SaveDataInstance]

var last_dict: Dictionary

var save_name: String

var save_id: StringName

var location_id: StringName

var spawn_id: StringName

var player_data:= PlayerData.new()






var location_data_list: Array[NewLocationData]

var entity_data_list: Array[NewEntityData]

var quest_data_list: Array[QuestData]







func register_instance(instance: SaveDataInstance) -> void:

	var uid = instance.get_uid()

	assert(!instances.has(uid), "Duplicate SaveDataInstance, uid: %s" % uid)

	instances[uid] = instance

	if instance is NewLocationData:

		location_data_list.append(instance)






func get_instance(uid: int) -> SaveDataInstance:

	assert(instances.has(uid), "SaveDataInstance not found, uid: %s" % uid)

	return instances[uid]






func get_location_data(_location_id: StringName) -> NewLocationData:

	for data in location_data_list:

		if data.location_id == _location_id:

			return data

	return null






func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	save_dict["location_id"] = location_id

	save_dict["spawn_id"] = spawn_id

	save_dict["location_data_list"] = []

	for location_data in location_data_list:

		save_dict["location_data_list"].append(location_data.get_dictionary())

	last_dict = save_dict

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> NewSaveData:

	var save_data = NewSaveData.new()

	save_data.last_dict = save_dict

	save_data.save_name = save_dict["save_name"]
	
	save_data.save_id = save_dict["save_id"]

	save_data.location_id = save_dict["location_id"]

	save_data.spawn_id = save_dict["spawn_id"]

	for dict in save_dict["location_data_list"]:

		var location_data = NewLocationData.load_dictionary(dict)

		save_data.register_instance(location_data)

	return save_data