extends Node




const SAVE_ROOT = "user://saves/"



var current_saves: Array[SaveData]




func _ready() -> void:

	_validate_path(SAVE_ROOT)










## Top-level Methods



func create_save(save_name: String) -> void:

	var save_dict = load("res://system/save_template.gd").new().data

	save_dict["save_name"] = save_name

	save_dict["save_id"] = _generate_save_id()

	_write_save_dict(save_dict)

	var save_data = SaveData.load_dictionary(save_dict)

	current_saves.append(save_data)






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

	var path = SAVE_ROOT + save_id + ".json"

	if !FileAccess.file_exists(path):

		return

	DirAccess.remove_absolute(path)
	

















func _get_save_data(save_id: String) -> SaveData:

	for save_data in current_saves:

		if save_data.save_id == save_id:

			return save_data

	return null





func _write_save_dict(save_dict: Dictionary) -> void:

	save_dict["last_save_unix"] = Time.get_unix_time_from_system()

	var path = SAVE_ROOT + save_dict["save_id"] + ".json"

	var file = FileAccess.open(path, FileAccess.WRITE)

	file.store_string(JSON.stringify(save_dict, " "))

	file.close()





func _generate_save_id() -> String:

	return str(randi())




func _validate_path(path: String) -> void:

	if !DirAccess.dir_exists_absolute(path):
		
		DirAccess.make_dir_absolute(path)