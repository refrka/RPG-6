class_name EquipmentData extends ItemData



signal projectile_equipped

signal projectile_unequipped



var projectile_data: ItemData












func equip_projectile_data(_projectile_data: ItemData) -> void:

	projectile_data = _projectile_data

	projectile_equipped.emit()




func unequip_projectile_data() -> ItemData:

	var _projectile_data = projectile_data

	projectile_data = null

	projectile_unequipped.emit()

	return _projectile_data







func get_equipment_type() -> EquipmentDef.EquipmentType:

	return item_def.equipment_type





func get_dictionary() -> Dictionary:

	var save_dict = super()

	if projectile_data:

		save_dict["projectile_data"] = projectile_data.get_dictionary()

	return save_dict




static func load_dictionary(save_dict: Dictionary) -> ItemData:

	var equipment_data = super(save_dict) as EquipmentData

	if save_dict.has("projectile_data"):

		equipment_data.projectile_data = ItemData.load_dictionary(save_dict["projectile_data"])

	return equipment_data
