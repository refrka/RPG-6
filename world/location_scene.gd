class_name LocationScene extends GameScene


@export var transition_zones: Node2D

@export var character_root: Node2D

@export var spawn_point_root: Node2D


var location_data: LocationData



func _ready() -> void:

	for transition_zone in transition_zones.get_children():

		transition_zone._setup(self)









func spawn_player(spawn_id: StringName) -> void:

	for spawn_point in spawn_point_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			var player = Game.get_player()

			player.reparent(character_root)

			player.global_position = spawn_point.global_position





func load_location_data(_location_data: LocationData) -> void:

	location_data = _location_data