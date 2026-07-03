class_name ItemDef extends Resource



@export var template: ItemDef

@export var unique_id: StringName

@export var item_id: StringName


@export var gold_value: float





func is_unique() -> bool:

	return unique_id != &""






