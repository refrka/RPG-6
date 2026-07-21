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

	Events.fire(GameStartingEvent)

	var save_data = Saves.load_save_data(save_id)

	if !save_data:

		return

	if is_active():

		end()

	_load_game(save_data)

	Events.fire(GameStartedEvent)




func end() -> void:

	Events.fire(GameEndingEvent)

	_unload_game()

	Events.fire(GameEndedEvent)




func save() -> void:

	Saves.save_game(active_save_data)




func pause() -> void:

	get_tree().paused = true




func resume() -> void:

	get_tree().pasued = false











func is_active() -> bool:

	return game_state == GameState.ACTIVE









func _load_game(save_data: SaveData) -> void:

	active_save_data = save_data




func _unload_game() -> void:

	active_save_data = null











