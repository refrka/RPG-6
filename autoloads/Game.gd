extends Node



enum GameState {

	MAIN_MENU,

	ACTIVE

}

var game_state: GameState

var active_save_data: SaveData








## Top-level Methods


func launch() -> void:

	pass



func restart() -> void:

	pass



func start(save_id: StringName) -> void:

	var save_data = Saves.load_save_data(save_id)

	if !save_data:

		return

	if is_active():

		end()

	_load_game(save_data)



func end() -> void:

	_unload_game()



func save() -> void:

	Saves.save_game(active_save_data)








func is_active() -> bool:

	return game_state == GameState.ACTIVE









func _load_game(save_data: SaveData) -> void:

	pass




func _unload_game() -> void:

	pass











