class_name EntityData extends Resource


var def: EntityDef

var node: EntityNode

var last_known_location_id: StringName

var last_known_position: Vector2

var last_save_dict: Dictionary











func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["entity_id"] = def.entity_id

	save_dict["last_known_location_id"] = last_known_location_id

	save_dict["last_known_position_x"] = last_known_position.x

	save_dict["last_known_position_y"] = last_known_position.y

	save_dict["components"] = {}

	for component in node.get_all_components():

		if component.has_method("get_dictionary"):

			save_dict["components"][component.get_component_name()] = component.get_dictionary()

	save_dict["inventory"] = node.inventory.get_dictionary()

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> EntityData:

	var entity_data = EntityData.new()

	entity_data.last_save_dict = save_dict

	var _def = Entities.get_entity_def(save_dict["entity_id"])

	entity_data.def = _def

	entity_data.last_known_location_id = save_dict["last_known_location_id"]

	entity_data.last_known_position.x = save_dict["last_known_position_x"]

	entity_data.last_known_position.y = save_dict["last_known_position_y"]

	return entity_data



