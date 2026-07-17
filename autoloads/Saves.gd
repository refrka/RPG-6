extends Node


signal save_list_updated


const SAVE_ROOT = "user://saves/"



var current_saves: Array[SaveData]




func _ready() -> void:

	_validate_path(SAVE_ROOT)

	_load_current_saves()

	process_mode = Node.PROCESS_MODE_ALWAYS










## Top-level Methods



func create_save(save_name: String) -> void:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_name"] = save_name

	save_dict["save_id"] = _generate_save_id()

	var save_data = SaveData.load_dictionary(save_dict)

	save_game(save_data)

	current_saves.append(save_data)

	save_list_updated.emit()






func save_game(save_data: SaveData) -> void:

	var save_dict = save_data.get_dictionary()

	save_dict["last_save_unix"] = Time.get_unix_time_from_system()

	_write_save_dict(save_dict)






func load_save_data(save_id: String) -> SaveData:

	var save_data = _get_save_data(save_id)
	
	if save_data != null:

		return save_data

	var path = SAVE_ROOT + save_id + ".json"

	if !FileAccess.file_exists(path):

		return null

	var json = JSON.new()

	var file = FileAccess.open(path, FileAccess.READ)

	json.parse(file.get_as_text())

	file.close()

	save_data = SaveData.load_dictionary(json.data)
	
	return save_data






func delete_save_data(save_id: String) -> void:

	var save_data = _get_save_data(save_id)
	
	if save_data == null:

		return

	current_saves.erase(save_data)

	save_list_updated.emit()

	var path = SAVE_ROOT + save_id + ".json"

	if !FileAccess.file_exists(path):

		return

	DirAccess.remove_absolute(path)
	










func _load_current_saves() -> void:

	for file_name in ResourceLoader.list_directory(SAVE_ROOT):

		var path = SAVE_ROOT + file_name

		if path.ends_with(".json"):

			var save_file = FileAccess.open(path, FileAccess.READ)

			var json = JSON.new()

			json.parse(save_file.get_as_text())

			save_file.close()

			var save_data = SaveData.load_dictionary(json.data)

			current_saves.append(save_data)

	save_list_updated.emit()






func _get_save_data(save_id: String) -> SaveData:

	for save_data in current_saves:

		if save_data.save_id == save_id:

			return save_data

	return null





func _write_save_dict(save_dict: Dictionary) -> void:

	var path = SAVE_ROOT + save_dict["save_id"] + ".json"

	var file = FileAccess.open(path, FileAccess.WRITE)

	file.store_string(JSON.stringify(save_dict, " "))

	file.close()





func _generate_save_id() -> String:

	var id = str(randi())

	while current_saves.any(func(data): return data.save_id == id):

		id = str(randi())

	return id




func _validate_path(path: String) -> void:

	if !DirAccess.dir_exists_absolute(path):
		
		DirAccess.make_dir_absolute(path)