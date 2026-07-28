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

	if save_data.quest_data_registry.has(quest_id):

		return save_data.quest_data_registry[quest_id]

	var quest_data = create_quest_data(quest_def)

	return quest_data




func get_quest_def(quest_id: StringName) -> QuestDef:

	if def_registry.has(quest_id):

		return def_registry[quest_id]

	return null




func get_quest_dialogue_nodes(target_entity: EntityNode) -> Array[QuestDialogueNode]:

	var dialogue_nodes: Array[QuestDialogueNode] = []

	var quest_defs = def_registry.values().duplicate()

	var source_defs = quest_defs.filter(func(def): return _is_quest_source_entity(def, target_entity))

	var recipient_defs = quest_defs.filter(func(def): return _is_quest_recipient_entity(def, target_entity))

	for def in source_defs:

		dialogue_nodes.append(def.source_dialogue_node)

	for def in recipient_defs:

		dialogue_nodes.append(def.recipient_dialogue_node)

	return dialogue_nodes




func get_quest_stage(quest_def: QuestDef) -> QuestStage:

	var quest_data = get_quest_data(quest_def)

	if quest_data:

		return quest_data.get_stage()

	return null



func get_quest_state(quest_def: QuestDef) -> QuestData.QuestState:

	var quest_data = get_quest_data(quest_def)

	if quest_data:

		return quest_data.get_state()

	return QuestData.QuestState.UNKNOWN




func set_quest_stage(quest_def: QuestDef, stage_index: int) -> QuestData:

	var quest_data = get_quest_data(quest_def)

	if !quest_data:

		quest_data = create_quest_data(quest_def)

	quest_data.set_stage(stage_index)

	return quest_data







func _is_quest_source_entity(quest_def: QuestDef, target_entity: EntityNode) -> bool:

	if !quest_def.source_dialogue_node:

		return false

	return quest_def.source_dialogue_node.quest_entity.match(target_entity)




func _is_quest_recipient_entity(quest_def: QuestDef, target_entity: EntityNode) -> bool:

	if !quest_def.recipient_dialogue_node:

		return false

	return quest_def.recipient_dialogue_node.quest_entity.match(target_entity)





func _load_quest_defs() -> void:

	var sub_dirs = ["res://quest/defs/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for file_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + file_name

			if path.ends_with(".tres"):

				var quest_def = load(path) as QuestDef

				def_registry[quest_def.quest_id] = quest_def

			elif path.ends_with("/"):

				sub_dirs.append(path)