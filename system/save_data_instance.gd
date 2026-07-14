class_name SaveDataInstance extends Resource





var uid: int

var node: Node

var last_dict: Dictionary



func _init() -> void:

	_generate_uid()

	



func get_uid() -> int:

	return uid



func _generate_uid() -> void:

	uid = randi()




func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["uid"] = uid

	last_dict = save_dict

	return save_dict




static func load_dictionary(save_dict: Dictionary) -> SaveDataInstance:

	var data = SaveDataInstance.new()

	data.uid = int(save_dict["uid"])

	return data