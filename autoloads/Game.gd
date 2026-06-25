extends Node






var active_save_data: SaveData








## Top-level Methods


func launch() -> void:

	pass



func restart() -> void:

	pass



func start(save_id: StringName) -> void:

	if active_save_data:

		end()

	active_save_data = Saves.load_save_data(save_id)



func end() -> void:

	pass



func save() -> void:

	Saves.save_game(active_save_data)



