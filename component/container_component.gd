class_name ContainerComponent extends InteractableComponent



@export var loot_table: LootTable



var looted:= false




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func interact() -> bool:

	var loot = loot_table.get_loot(randf())

	var player = Game.get_player()

	for item_id in loot:

		var count = loot[item_id]

		player.inventory.add_item(item_id, count)

	looted = true

	return false




func can_interact() -> bool:

	return !looted