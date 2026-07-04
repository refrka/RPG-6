class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor




func _ready() -> void:

	data = PlayerData.new()






func _initialize() -> void:

	super()

	interaction_sensor.setup(self)

	var save_data = Game.get_save_data()

	load_data(save_data.player_data)




func one_time_setup() -> void:

	super()

	var save_data = Game.get_save_data()

	save_data.inventory = inventory




func reset() -> void:

	inventory.clear()



func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	if !inventory.inventory_updated.is_connected(_on_inventory_updated):

		inventory.inventory_updated.connect(_on_inventory_updated)





func _activate() -> void:

	super()

	var navigation_component = get_component("navigation")

	navigation_component._deactivate()





func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_save_data()

	save_data.location_id = location_id

	save_data.spawn_id = spawn_id






func _on_inventory_updated(item_id: StringName, change: int, count: int) -> void:

	print("fire it")

	Events.fire(ItemsAddedToInventoryEvent, {"item_id": item_id, "change": change, "count": count})