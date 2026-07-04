class_name EntityData extends Resource


var def: EntityDef

var node: EntityNode

var last_known_location_id: StringName

var last_known_position: Vector2













func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["entity_id"] = def.entity_id

	save_dict["last_known_location_id"] = last_known_location_id

	save_dict["last_known_position_x"] = last_known_position.x

	save_dict["last_known_position_y"] = last_known_position.y

	print(node)

	return save_dict






static func load_dictionary(save_dict: Dictionary) -> EntityData:

	var entity_data = EntityData.new()

	var _def = Entities.get_def(save_dict["entity_id"])

	entity_data.def = _def

	entity_data.last_known_location_id = save_dict["last_known_location_id"]

	entity_data.last_known_position.x = save_dict["last_known_position_x"]

	entity_data.last_known_position.y = save_dict["last_known_position_y"]

	return entity_data



