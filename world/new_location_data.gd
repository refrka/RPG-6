class_name NewLocationData extends SaveDataInstance



@export var location_id: StringName










func get_dictionary() -> Dictionary:

	var save_dict = super()

	save_dict["location_id"] = location_id

	last_dict = save_dict

	return save_dict








static func load_dictionary(save_dict: Dictionary) -> SaveDataInstance:

	var instance = super(save_dict)

	var data = NewLocationData.from_instance(instance)

	data.location_id = save_dict["location_id"]

	return data




static func from_instance(instance: SaveDataInstance) -> NewLocationData:

	var data = NewLocationData.new()

	data.uid = instance.uid

	return data