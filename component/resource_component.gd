class_name ResourceComponent extends InteractableComponent




@export var loot_table: LootTable


var harvested:= false






func _can_interact() -> bool:

	return !harvested




func _execute() -> void:

	_set_harvested_state(true)

	var loot_list = loot_table.get_loot()

	Game.drop_items(loot_list, entity.global_position)

	interaction_ended.emit()










func _set_harvested_state(state: bool) -> void:

	harvested = state

	if harvested:

		entity.body_sprite.frame = 1

	else:

		entity.body_sprite.frame = 0