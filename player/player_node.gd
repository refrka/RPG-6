class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor




func _ready() -> void:

	data = PlayerData.new()




func one_time_setup() -> void:

	super()

	var save_data = Game.get_save_data()

	save_data.inventory = inventory

	var player_profile = UI.get_overlay(PlayerProfile)

	player_profile.initialize(self)




func reset() -> void:

	inventory.clear()







func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_save_data()

	save_data.location_id = location_id

	save_data.spawn_id = spawn_id





func _initialize() -> void:

	super()

	interaction_sensor.setup(self)




