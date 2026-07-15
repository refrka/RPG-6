class_name EntityData extends Resource




var data_id: StringName

var def: EntityDef

var node: EntityNode

var last_dict: Dictionary








func get_dictionary() -> Dictionary:

	var save_dict = {}

	last_dict = save_dict

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> EntityData:

	var entity_data = EntityData.new()

	return entity_data


