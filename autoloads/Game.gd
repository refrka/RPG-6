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

	Scenes.load_scene(Location)





func end() -> void:

	save()

	active_save_data = null





func save() -> void:

	if !active_save_data:

		return

	Saves.save_game(active_save_data)

	print("Game saved (%s : %s)" % [active_save_data.save_name, active_save_data.save_id])





func exit() -> void:

	end()

	Scenes.load_scene(MainMenu)















func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		save()