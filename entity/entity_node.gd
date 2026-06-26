class_name EntityNode extends PhysicsBody2D



@export var def: EntityDef

var data: EntityData

@export var component_root: ComponentRoot











func _enter_tree() -> void:

	component_root.setup(self)

	









func get_component(component_name: StringName) -> Component:

	for component in component_root.get_children():

		if component.get_component_name() == component_name:

			return component

	return null








func get_entity_id() -> StringName:

	var entity_id = def.entity_id

	if def.template:

		entity_id = def.template.entity_id

	return entity_id






func load_data(entity_data: EntityData) -> void:

	data = entity_data

	data.node = self

	print("loading data")

	global_position = data.last_known_position

	print("position set to: ", global_position)





func _get_dictionary() -> Dictionary:

	var save_dict = {}

	return save_dict





func _load_dictionary() -> void:

	pass






func _create_entity_data() -> EntityData:

	var entity_data = EntityData.new()

	entity_data.def = def

	if def.unique_id != &"":

		var save_data = Game.get_save_data()

		save_data.entity_data_list.append(save_data)

	entity_data.node = self

	return entity_data