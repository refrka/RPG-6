class_name PlayerNode extends CharacterNode





func get_display_name() -> String:

	var save_data = Game.get_save_data()

	return save_data.save_name