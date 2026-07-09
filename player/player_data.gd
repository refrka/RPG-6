class_name PlayerData extends CharacterData








func _get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["components"] = {}

	if node:

		for component in node.get_all_components():

			if component.has_method("get_dictionary"):

				save_dict["components"][component.get_component_name()] = component.get_dictionary()

	return save_dict