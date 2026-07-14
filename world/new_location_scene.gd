class_name NewLocationScene extends NewGameScene


signal location_state_updated(location_scene: NewLocationScene)


enum LocationState {

	LOADED,

	INITIALIZED,

	ACTIVE,

}


var location_state: LocationState

var data: NewLocationData





@export var location_id: StringName

@export var character_root: Node2D

@export var object_root: Node2D

@export var feature_root: Node2D

@export var transition_root: Node2D

@export var spawn_root: Node2D







func _initialize(_data: NewLocationData) -> void:

	data = _data

	_set_location_state(LocationState.INITIALIZED)

	for character_node in character_root.get_children():

		character_node._setup()

	for object_node in object_root.get_children():

		object_node._setup()

	for transition_zone in transition_root.get_children():

		transition_zone._initialize(self)

		transition_zone._activate()

	for feature in feature_root.get_children():

		feature._initialize(self)

		feature._activate()









func get_nearest_spawn_point(target_entity: EntityNode) -> SpawnPoint:

	var nearest_spawn: SpawnPoint = null

	var nearest_distance:= INF

	for spawn_point in spawn_root.get_children():

		var distance = target_entity.global_position.distance_to(spawn_point.global_position)

		if !nearest_spawn or distance < nearest_distance:

			nearest_spawn = spawn_point

			nearest_distance = distance

	return nearest_spawn



	





func _enter(spawn_id: StringName = "") -> void:

	_activate()

	if spawn_id == "":

		var save_data = Game.get_new_save_data()

		spawn_id = save_data.spawn_id

	_spawn_player(spawn_id)





func _exit() -> void:

	_deactivate()





func _activate() -> void:

	super()

	_set_location_state(LocationState.ACTIVE)





func _deactivate() -> void:

	super()

	_set_location_state(LocationState.INITIALIZED)









func _spawn_player(spawn_id: StringName) -> void:

	var player = Game.get_player()

	player.reparent(character_root)

	var spawn_position = _get_spawn_position(spawn_id)

	player.global_position = spawn_position

	player._update_location_data(location_id, spawn_id)

	player._activate()










func _get_spawn_position(spawn_id: StringName) -> Vector2:

	for spawn_point in spawn_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point.global_position

	return Vector2.ZERO





func _set_location_state(new_state: LocationState) -> void:

	location_state = new_state

	location_state_updated.emit(self)







