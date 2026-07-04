class_name ItemDef extends Resource



@export var template: ItemDef

@export var unique_id: StringName

@export var item_id: StringName

@export var display_name: StringName

@export var gold_value: int





func is_unique() -> bool:

	return unique_id != &""






