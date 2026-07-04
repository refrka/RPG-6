class_name Effect extends Resource



@export var effect_id: StringName

@export var display_name: String








func apply_effect(_target_entity: EntityNode) -> void:

	pass




func get_display_name() -> String:

	return display_name