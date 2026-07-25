extends Node



var def_registry: Dictionary[StringName, QuestDef]







func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_load_quest_defs()





func create_quest_data(quest_def: QuestDef) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest_def = quest_def

	var save_data = Game.get_save_data()

	save_data.quest_data_registry[quest_def.quest_id] = quest_data

	return quest_data




func get_quest_data(quest_def: QuestDef) -> QuestData:

	var save_data = Game.get_save_data()

	var quest_id = quest_def.quest_id

	if save_data.has(quest_id):

		return save_data[quest_id]

	return null



func get_quest_def(quest_id: StringName) -> QuestDef:

	if def_registry.has(quest_id):

		return def_registry[quest_id]

	return null







func _load_quest_defs() -> void:

	var sub_dirs = ["res://ui/quest/defs/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for file_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + file_name

			if path.ends_with(".tres"):

				var quest_def = load(path) as QuestDef

				def_registry[quest_def.quest_id] = quest_def

			elif path.ends_with("/"):

				sub_dirs.append(path)