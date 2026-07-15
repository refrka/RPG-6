class_name LocationScene extends GameScene


@export var location_id: StringName

var data: LocationData












func _enter() -> void:

	_activate()

	var location_data = Game.get_location_data(location_id)

	_load_data(location_data)




func _exit() -> void:

	_deactivate()















func _load_data(location_data: LocationData) -> void:

	if location_data == null:

		location_data = LocationData.new()

		location_data.location_id = location_id

	data = location_data