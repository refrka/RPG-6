class_name WorldScene extends GameScene




var active_location: LocationScene

var location_data_list: Array[LocationData]

var location_scene_list: Array[LocationScene]










# Location Loading Steps
# [ The goal is to allow the storing/restoring of location scenes instead of instantiating/loading one at a  time. ]
# [ This comes from working on Cutscenes - need a way to easily "cut" to another location, do a scene, then return to original scene. ]
# 
# 1. Load
# 	> Instantiate and store only
# 	> GameSceneState.UNLOADED
# 	>>> new_load_location()
# 
# 1.5. Focus
# 	> Show the scene visually regardless of entities
# 
# 2. Initialize
# 	> 2-step process
# 	a) Objects
# 		> Populate location ObjectNodes
# 	b) Characters
# 		> Populate location CharacterNodes
# 
# 3. Spawn player/activate
# 	> Spawn player in the location
# 	> Activate all entities, features, etc





func new_load_location(location_id: StringName) -> LocationScene:

	var location_scene = _get_location_scene(location_id)

	if !location_scene_list.has(location_scene):

		location_scene_list.append(location_scene)

	return location_scene







func enter_location(location_id: StringName) -> LocationScene:

	if active_location:

		active_location._unload()

	var location_scene = new_load_location(location_id)

	var location_data = _get_location_data(location_scene)

	location_scene._initialize(location_data)
	
	return location_scene







func load_location(location_id: StringName) -> LocationScene:

	var location_scene = _get_location_scene(location_id)

	if active_location and active_location != location_scene:

		unload_location()

	if !location_scene.is_inside_tree():

		add_child(location_scene)

	active_location = location_scene

	var location_data = _get_location_data(location_scene)

	active_location._initialize(location_data)

	return active_location






func unload_location() -> void:

	location_scene_list.erase(active_location)

	active_location._unload()

	active_location.queue_free()


















func _change_active_location(new_location: LocationScene) -> void:

	if active_location:

		active_location._exit()

		remove_child(active_location)

	active_location = new_location

	add_child(active_location)

	active_location._enter()








func _get_location_data(location_scene: LocationScene) -> NewLocationData:

	var data: NewLocationData = null

	var save_data = Game.get_new_save_data()

	for location_data in save_data.location_data_list:

		if location_data.location_id == location_scene.location_id:

			data = location_data

	if data == null:

		data = _create_location_data(location_scene)

	return data





func _get_location_scene(location_id: StringName) -> LocationScene:

	for location_scene in location_scene_list:

		if location_scene.location_id == location_id:

			return location_scene

	return null
	



func _create_location_data(location_scene: LocationScene) -> NewLocationData:

	var data = NewLocationData.new()

	data.node = location_scene

	data.location_id = location_scene.location_id

	var save_data = Game.get_new_save_data()

	save_data.register_instance(data)

	return data