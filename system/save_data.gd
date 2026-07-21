class_name SaveData extends Resource




var save_id: String

var save_name: String

var last_dict: Dictionary

var location_data_list: Array[LocationData]

var entity_data_registry: Dictionary[StringName, EntityData]

var quest_data_list: Array[QuestData]




var player_data: PlayerData




var current_location_id: StringName

var current_spawn_id: StringName





func _initialize() -> void:

	Globals.load_dictionary(last_dict["globals"])





func get_last_location_id() -> StringName:

	return last_dict["current_location_id"]



func get_last_spawn_id() -> StringName:

	return last_dict["current_spawn_id"]



func add_location_data(location_data: LocationData) -> void:

	if !location_data_list.has(location_data):

		location_data_list.append(location_data)





























func get_dictionary() -> Dictionary:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["globals"] = Globals.get_dictionary()

	save_dict["save_id"] = save_id

	save_dict["save_name"] = save_name

	save_dict["current_location_id"] = current_location_id

	save_dict["current_spawn_id"] = current_spawn_id

	save_dict["player_data"] = player_data.get_dictionary()

	last_dict = save_dict

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.last_dict = save_dict

	save_data.save_id = save_dict["save_id"]

	save_data.save_name = save_dict["save_name"]

	save_data.current_location_id = save_dict["current_location_id"]

	save_data.current_spawn_id = save_dict["current_spawn_id"]

	save_data.player_data = PlayerData.load_dictionary(save_dict["player_data"])

	return save_data