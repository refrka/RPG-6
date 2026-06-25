class_name EntityNode extends PhysicsBody2D





@export var component_root: ComponentRoot











func _enter_tree() -> void:

	component_root.setup(self)











func get_component(component_name: StringName) -> Component:

	for component in component_root.get_children():

		if component.get_component_name() == component_name:

			return component

	return null