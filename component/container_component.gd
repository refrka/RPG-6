class_name ContainerComponent extends InteractableComponent



@export var loot_table: LootTable



var looted:= false




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS






func interact() -> bool:

	var loot = loot_table.get_loot(randf())

	var player = Game.get_player()

	for item_data in loot:

		player.inventory.add_item_data(item_data)

	looted = true

	entity.body_sprite.frame = 1

	return false






func can_interact() -> bool:

	return !looted







func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["component_name"] = get_component_name()

	save_dict["looted"] = looted

	return save_dict





func load_dictionary(save_dict: Dictionary) -> void:

	looted = save_dict["looted"]