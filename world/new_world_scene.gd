class_name NewWorldScene extends NewGameScene


signal active_location_changed(new_location: NewLocationScene)


var active_location: NewLocationScene

var location_registry: Dictionary[StringName, NewLocationScene]








func activate_location(location_id: StringName) -> NewLocationScene:

	var location_scene = get_location(location_id)

	if active_location:

		active_location._deactivate()

	return location_scene






func enter_location(location_id: StringName) -> NewLocationScene:

	if active_location:

		active_location._exit()

	var location_scene = load_location(location_id)

	initialize_location(location_scene)

	location_scene._enter()
	
	return location_scene





func initialize_location(location_scene: NewLocationScene) -> void:

	var location_data = _get_location_data(location_scene)

	location_scene._initialize(location_data)





func load_location(location_id: StringName) -> NewLocationScene:

	var location_scene = _get_location_scene(location_id)

	if !location_registry.has(location_id):

		location_registry[location_id] = location_scene

	_change_active_location(location_scene)

	return location_scene





func get_location(location_id: StringName) -> NewLocationScene:

	if location_registry.has(location_id):

		return location_registry[location_id]

	return null








func _change_active_location(new_location: NewLocationScene) -> void:

	if active_location:

		remove_child(active_location)

	active_location = new_location

	add_child(active_location)

	active_location_changed.emit(active_location)




	


func _get_location_data(location_scene: NewLocationScene) -> NewLocationData:

	var data = Game.get_location_data(location_scene.location_id)

	if data == null:

		data = _create_location_data(location_scene)

	return data






func _get_location_scene(location_id: StringName) -> NewLocationScene:

	if location_registry.has(location_id):

		return location_registry[location_id]

	return NewScenes.load_location_scene(location_id)





	


func _create_location_data(location_scene: NewLocationScene) -> NewLocationData:

	var data = NewLocationData.new()

	data.node = location_scene

	data.location_id = location_scene.location_id

	var save_data = Game.get_new_save_data()

	save_data.register_instance(data)

	return data