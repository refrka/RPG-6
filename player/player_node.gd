class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor




func _ready() -> void:

	new_data = PlayerData.new()






func _setup() -> void:

	if initialized:

		return

	super()

	interaction_sensor.setup(self)




func _initialize(entity_data: NewEntityData) -> void:

	load_data(entity_data)




func one_time_setup() -> void:

	super()

	var save_data = Game.get_new_save_data()

	save_data.inventory = inventory






func reset() -> void:

	pass






func get_display_name() -> String:

	var save_data = Game.get_save_data()

	return save_data.save_name





func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	if !inventory.item_data_count_updated.is_connected(_on_item_data_count_updated):

		inventory.item_data_count_updated.connect(_on_item_data_count_updated)

	inventory.initialize()





func _activate() -> void:

	super()

	var navigation_component = get_component("navigation")

	navigation_component._deactivate()





func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_new_save_data()

	save_data.location_id = location_id

	save_data.spawn_id = spawn_id






func _on_item_data_count_updated(amount: int, item_data: ItemData, removed: bool) -> void:

	amount = amount * -1 if removed else amount

	Events.fire(ItemsAddedToInventoryEvent, {"item_name": item_data.get_def().display_name, "amount": amount, "count": item_data.get_count()})