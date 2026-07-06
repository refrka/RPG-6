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

	_load_location_data(_location_data)

	for character_node in character_root.get_children():

		character_node._initialize()

	for object_node in object_root.get_children():

		object_node._initialize()

	for transition_zone in transition_zones.get_children():

		transition_zone._initialize(self)

	for feature in feature_root.get_children():

		feature._initialize(self)

	_load_entity_data()






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






func spawn_player(spawn_id: StringName) -> void:

	var player = Game.get_player()

	player.reparent(character_root)

	var spawn_point = get_spawn_point(spawn_id)

	player.global_position = spawn_point.global_position

	player._update_location_data(location_id, spawn_id)





func _load_location_data(_location_data: LocationData) -> void:

	location_data = _location_data






## Create data for unique entities without EntityData, assign saved EntityData to local entities, remove/spawn entities according to location
func _load_entity_data() -> void:

	var location_entity_data = _get_location_entity_data()

	# Update authored entities with saved EntityData
	# Create new data for authored entities with unique_ids (once during first load)
	# Remove entities that have a different location_id
	# Spawn non-authored entities with this location_id

	for character_node in character_root.get_children():

		var unique_id = character_node.def.unique_id

		if unique_id != &"":

			var entity_data = Game.get_entity_data(unique_id)

			if entity_data == null:

				entity_data = Entities.create_data(character_node)

				character_node.one_time_setup()

				entity_data.last_known_location_id = location_id

				entity_data.last_known_position = character_node.global_position

			else:

				if entity_data.last_known_location_id != location_id:

					character_node.queue_free()

				else:

					location_entity_data.erase(entity_data)

			character_node.load_data(entity_data)

	for entity_data in location_entity_data:

		var node = Entities.create_node(entity_data.def)

		if node is CharacterNode:

			character_root.add_child(node)

		node.load_data(entity_data)




func _get_location_entity_data() -> Array[EntityData]:

	var data_list: Array[EntityData] = []

	var save_data = Game.get_save_data()

	data_list = save_data.entity_data_list.filter(func(data): return data.last_known_location_id == location_id)

	return data_list