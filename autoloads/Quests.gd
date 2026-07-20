extends Node




var def_registry: Dictionary[StringName, QuestDef]








func _ready() -> void:

	_load_quest_defs()

	Events.subscribe(QuestStartedEvent, _on_quest_started)

	Events.subscribe(QuestCompletedEvent, _on_quest_completed)







func get_quest_def(quest_id: StringName) -> QuestDef:

	if def_registry.has(quest_id):

		return def_registry[quest_id]

	return null




func get_quest_data(quest_id: StringName) -> QuestData:

	for quest_data in get_all_quest_data():

		if quest_data.quest_id == quest_id:

			return quest_data

	return null




func get_quest_state(quest_id: StringName) -> QuestData.QuestState:

	var quest_data = get_quest_data(quest_id)
	
	if !quest_data:

		return QuestData.QuestState.UNKNOWN

	return quest_data.get_state()




func get_all_quest_data() -> Array[QuestData]:

	var save_data = Game.get_save_data()

	return save_data.quest_data_list




func get_quests_for_source_entity(entity_node: EntityNode) -> Array[QuestDef]:

	var quests: Array[QuestDef] = []

	quests.assign(def_registry.values().duplicate())

	var source_quests = quests.filter(func(def: QuestDef): return IsSourceForQuest.run({"quest_def": def, "entity_node": entity_node}))

	return source_quests



func get_quests_for_recipient_entity(entity_node: EntityNode) -> Array[QuestDef]:

	var quests: Array[QuestDef] = []

	quests.assign(def_registry.values().duplicate())

	var source_quests = quests.filter(func(def: QuestDef): return IsRecipientForQuest.run({"quest_def": def, "entity_node": entity_node}))

	return source_quests










func get_dialogue_nodes_for_entity(entity_node: EntityNode) -> Array[DialogueNode]:

	var entity_def = entity_node.get_def()

	var unevaluated_dialogue_nodes: Array[DialogueNode] = []

	var evaluated_dialolgue_nodes: Array[DialogueNode] = []

	# Check source and recipient nodes

	var source_quest_defs = get_quests_for_source_entity(entity_node)

	var recipient_quest_defs = get_quests_for_recipient_entity(entity_node)

	for def in source_quest_defs:

		var quest_data = get_quest_data(def.quest_id)

		if !quest_data or (quest_data.get_state() == QuestData.QuestState.AVAILABLE or quest_data.get_state() == QuestData.QuestState.UNKNOWN):

			def.source_dialogue_node.assign_quest_id(def.quest_id)

			unevaluated_dialogue_nodes.append(def.source_dialogue_node)

	for def in recipient_quest_defs:

		var quest_data = get_quest_data(def.quest_id)

		if quest_data and quest_data.get_state() == QuestData.QuestState.READY:

			def.recipient_dialogue_node.assign_quest_id(def.quest_id)

			unevaluated_dialogue_nodes.append(def.recipient_dialogue_node)

	# Check active quest data for objective-related nodes

	var save_data = Game.get_save_data()

	var active_quest_ids: Array[StringName] = []

	for quest_data in save_data.quest_data_list:

		active_quest_ids.append(quest_data.quest_id)

		unevaluated_dialogue_nodes.append_array(quest_data.get_stage_dialogue_nodes(entity_node))

	if entity_def.dialogue_library:

		unevaluated_dialogue_nodes.append_array(entity_def.dialogue_library.get_quest_dialogue_nodes(active_quest_ids))

	for dialogue_node in unevaluated_dialogue_nodes:

		if dialogue_node.show_condition_set and !dialogue_node.show_condition_set.evaluate({"dialogue_node": dialogue_node, "quest_entity": entity_node}):

			continue

		evaluated_dialolgue_nodes.append(dialogue_node)

	return evaluated_dialolgue_nodes











func set_quest_state(quest_id: StringName, state: QuestData.QuestState) -> QuestData:

	var quest_data = get_quest_data(quest_id)

	if !quest_data:

		quest_data = _create_quest_data(quest_id)

	quest_data.set_state(state)

	Events.fire(QuestStateChangedEvent, {"quest_data": quest_data})

	return quest_data





func set_quest_stage(quest_id: StringName, stage: int) -> void:

	var quest_data = get_quest_data(quest_id)

	if quest_data:

		quest_data.set_stage(stage)











func _create_quest_data(quest_id: StringName) -> QuestData:
	
	var quest_data = QuestData.new()

	quest_data.quest_id = quest_id

	quest_data.state_changed.connect(_on_quest_state_changed)

	quest_data.objective_completed.connect(_on_objective_completed)

	quest_data.stage_completed.connect(_on_stage_completed)

	var save_data = Game.get_save_data()

	save_data.quest_data_list.append(quest_data)

	return quest_data










func _on_quest_dialogue_node_entered(event: Event) -> void:

	var dialogue_node = event.data["dialogue_node"]

	var quest_data = get_quest_data(dialogue_node.quest_id)

	if !quest_data:

		set_quest_state(dialogue_node.quest_id, QuestData.QuestState.AVAILABLE)




func _on_quest_started(event: Event) -> void:

	pass


func _on_quest_state_changed(quest_data: QuestData) -> void:

	pass



func _on_objective_completed(quest_data: QuestData, objective: QuestObjective) -> void:

	pass



func _on_stage_completed(quest_data: QuestData, stage: QuestStage) -> void:

	pass



func _on_quest_completed(event: Event) -> void:

	pass









func _load_quest_defs() -> void:

	var sub_dirs = ["res://quest/defs/"]

	while !sub_dirs.is_empty():

		var sub_dir = sub_dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(sub_dir):

			var path = sub_dir + dir_name

			if path.ends_with(".tres"):

				var def = load(path)

				if not def is QuestDef:

					continue

				def_registry[def.quest_id] = def

			elif path.ends_with("/"):

				sub_dirs.append(path)






