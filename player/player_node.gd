class_name PlayerNode extends CharacterNode


@export var interaction_sensor: InteractionSensor








func _update_location_data(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_save_data()

	save_data.location_id = location_id

	save_data.spawn_id = spawn_id





func _initialize() -> void:

	super()

	interaction_sensor.setup(self)

	load_data(PlayerData.new())

