extends Node




var def_registry: Dictionary[StringName, QuestDef]








func _ready() -> void:

	_load_quest_defs()












func set_quest_state(quest_id: StringName, state: QuestData.QuestState) -> QuestData:

	var quest_data = get_quest_data(quest_id)

	if quest_data:

		quest_data.set_state(state)

	var quest_def = get_quest_def(quest_id)

	if quest_def == null:

		return null

	quest_data = _create_quest_data(quest_id, state)

	return quest_data





func get_quest_state(quest_id: StringName) -> QuestData.QuestState:

	var quest_data = get_quest_data(quest_id)

	if quest_data:

		return quest_data.state

	return QuestData.QuestState.UNKNOWN





func get_quest_data(quest_id: StringName) -> QuestData:

	var save_data = Game.get_save_data()

	for quest_data in save_data.quest_data_list:

		if quest_data.quest_id == quest_id:

			return quest_data

	return null




func get_quest_def(quest_id: StringName) -> QuestDef:

	if def_registry.has(quest_id):

		return def_registry[quest_id]

	return null








func get_quests_with_source(entity_node: EntityNode) -> Array[QuestDef]:

	var quest_defs: Array[QuestDef] = []

	for def in def_registry.values():

		for source in def.sources:

			if source.match(entity_node):
				
				if def.available_condition_set and !def.available_condition_set.evaluate():

					continue

				quest_defs.append(def)

	return quest_defs













func _create_quest_data(quest_id: StringName, initial_state:= QuestData.QuestState.ACTIVE) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest_id = quest_id

	quest_data.state = initial_state

	return quest_data








func _load_quest_defs() -> void:

	var sub_dirs = ["res://quest/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with(".tres"):

				var def = load(path)

				def_registry[def.quest_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)