class_name LocationScene extends GameScene


@export var location_id: StringName

@export var transition_zones: Node2D

@export var character_root: Node2D

@export var spawn_point_root: Node2D


var location_data: LocationData



func _ready() -> void:

	super()

	for transition_zone in transition_zones.get_children():

		transition_zone._setup(self)

	_load_entity_data()








func _load_entity_data() -> void:

	var save_data = Game.get_save_data()

	for character_node in character_root.get_children():

		var unique_id = character_node.def.unique_id

		if unique_id != &"":

			var data_list = save_data.entity_data_list.filter(func(data): return data.unique_id == unique_id)

			if !data_list.is_empty():

				var character_data = save_data.entity_data_list.filter(func(data): return data.unique_id == unique_id).front()

				character_node.load_entity_data(character_data)










func spawn_player(spawn_id: StringName) -> void:

	for spawn_point in spawn_point_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			var player = Game.get_player()

			player.reparent(character_root)

			player.global_position = spawn_point.global_position








func load_location_data(_location_data: LocationData) -> void:

	location_data = _location_data