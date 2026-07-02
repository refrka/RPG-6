class_name PlayerInfoPanel extends MarginContainer



@export var player_name_label: Label




func load_info(_player: PlayerNode) -> void:

	var save_data = Game.get_save_data()

	player_name_label.text = save_data.save_name