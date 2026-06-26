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









func load_entity_data(entity_data: EntityData) -> void:

	data = entity_data







func _get_dictionary() -> Dictionary:

	var save_dict = {}

	return save_dict





func _load_dictionary() -> void:

	pass