class_name LocationScene extends GameScene



enum Region {

	FOREST,

}


@export var region: Region

@export var location_id: StringName

@export var transition_zones: Node2D

@export var character_root: Node2D

@export var object_root: Node2D

@export var spawn_point_root: Node2D

@export var feature_root: Node2D

@export var marker_root: Node2D




var location_data: LocationData






func _initialize(_location_data: LocationData) -> void:

	for character_node in character_root.get_children():

		character_node._initialize()

	for object_node in object_root.get_children():

		object_node._initialize()

	for transition_zone in transition_zones.get_children():

		transition_zone._initialize(self)

	for feature in feature_root.get_children():

		feature._initialize(self)

	_load_location_data(_location_data)

	_load_container_states()

	_load_entity_data()

	Events.subscribe(ContainerStateChanged, _on_container_state_changed)






func get_spawn_point(spawn_id: StringName) -> SpawnPoint:

	for spawn_point in spawn_point_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point

	return null





func get_nearest_spawn_point(target_entity: EntityNode) -> SpawnPoint:

	var nearest_spawn: SpawnPoint = null

	var nearest_distance:= INF

	for spawn_point in spawn_point_root.get_children():

		var distance = target_entity.global_position.distance_to(spawn_point.global_position)

		if !nearest_spawn or distance < nearest_distance:

			nearest_spawn = spawn_point

			nearest_distance = distance

	return nearest_spawn





func get_entity_marker(marker_id: StringName) -> EntityMarker:

	for marker in marker_root.get_children():

		if marker.marker_id == marker_id:

			return marker

	return null




func get_entity_index(entity_node: EntityNode) -> int:

	var list: Array = []

	if entity_node is CharacterNode:

		list = character_root.get_children()

	elif entity_node is ObjectNode:

		list = object_root.get_children()

	return list.find(entity_node)



func get_objects_with_component(component_name: StringName) -> Array[ObjectNode]:

	var objects: Array[ObjectNode] = []

	for object in object_root.get_children():

		if object.get_component(component_name) != null:

			objects.append(object)

	return objects





func get_container_states() -> Array[bool]:

	print("getting the states!!")

	var states: Array[bool] = []

	var container_nodes = get_objects_with_component("container")

	for node in container_nodes:

		var container_component = node.get_component("container")

		states.append(container_component.looted)

	return states





func spawn_player(spawn_id: StringName) -> void:

	var player = Game.get_player()

	player.reparent(character_root)

	var spawn_point = get_spawn_point(spawn_id)

	player.global_position = spawn_point.global_position

	player._update_location_data(location_id, spawn_id)





func _load_location_data(_location_data: LocationData) -> void:

	location_data = _location_data

	location_data.location_scene = self

	print("loading loc data")

	if !location_data.discovered:

		print("this not discovered")

		location_data.container_states = get_container_states()

		location_data.discovered = true

		Events.fire(LocationDiscoveredEvent, {"location_id": location_id})







## Create data for unique entities without EntityData, assign saved EntityData to local entities, remove/spawn entities according to location
func _load_entity_data() -> void:

	var location_entity_data = _get_location_entity_data()

	# Update authored entities with saved EntityData
	# Create new data for authored entities with unique_ids (once during first load)
	# Remove entities that have a different location_id
	# Spawn non-authored entities with this location_id

	_load_characters(location_entity_data)

	_load_objects(location_entity_data)

	for entity_data in location_entity_data:

		var node = Entities.create_node(entity_data.def)

		if node is CharacterNode:

			character_root.add_child(node)

		elif node is ObjectNode:

			object_root.add_child(node)

		node.load_data(entity_data)




func _load_characters(location_entity_data: Array[EntityData]) -> void:

	for character_node in character_root.get_children():

		var unique_id = character_node.get_unique_id()

		if unique_id != &"":

			var entity_data = Game.get_entity_data(unique_id)

			if entity_data == null:

				entity_data = Entities.create_data(character_node)

				character_node.one_time_setup()

				entity_data.last_known_location_id = location_id

				entity_data.last_known_position = character_node.global_position

			else:

				entity_data.node = character_node

				if entity_data.last_known_location_id != location_id:

					character_node.queue_free()

				else:

					location_entity_data.erase(entity_data)

			character_node.load_data(entity_data)





func _load_objects(location_entity_data: Array[EntityData]) -> void:

	for object_node in object_root.get_children():

		var unique_id = object_node.get_unique_id()

		if unique_id != &"":

			var entity_data = Game.get_entity_data(unique_id)

			if entity_data == null:

				entity_data = Entities.create_data(object_node)

				object_node.one_time_setup()

				entity_data.last_known_location_id = location_id

				entity_data.last_known_position = object_node.global_position

			else:

				entity_data.node = object_node

				if entity_data.last_known_location_id != location_id:

					object_node.queue_free()

				else:

					location_entity_data.erase(entity_data)

			object_node.load_data(entity_data)







func _get_location_entity_data() -> Array[EntityData]:

	var data_list: Array[EntityData] = []

	var save_data = Game.get_save_data()

	data_list = save_data.entity_data_list.filter(func(data): return data.last_known_location_id == location_id)

	return data_list





func _load_container_states() -> void:

	var container_nodes = get_objects_with_component("container")

	if container_nodes.is_empty():

		return

	for i in range(container_nodes.size()):

		var container_node = container_nodes[i]

		var container_component = container_node.get_component("container")

		container_component.set_loot_state(location_data.container_states[i])












func _on_container_state_changed(event: Event) -> void:

	var container_node = event.data["container_node"]
	
	var state = event.data["state"]

	var index = get_entity_index(container_node)

	location_data.update_container_state(index, state)

