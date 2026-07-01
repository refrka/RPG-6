extends Node




var def_registry: Dictionary[StringName, QuestDef]








func _ready() -> void:

	_load_quest_defs()
















func set_quest_state(quest_id: StringName, new_state: QuestData.QuestState) -> QuestData:

	var quest_data = get_quest_data(quest_id)

	quest_data.set_state(new_state)

	if new_state == QuestData.QuestState.ACTIVE:

		quest_data.set_stage(0)

	return quest_data








func get_quest_state(quest_id: StringName) -> QuestData.QuestState:

	var quest_data = get_quest_data(quest_id)

	if quest_data:

		return quest_data.state

	return QuestData.QuestState.UNKNOWN




func get_quest_stage(quest_id: StringName, stage_index:= -1) -> QuestStage:

	var quest_data = get_quest_data(quest_id)

	if !quest_data:

		return null
	
	return quest_data.get_stage(stage_index)




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




func get_quest_dialogue_nodes(entity_node: EntityNode) -> Array[QuestDialogueNode]:

	var unevaluated_dialogue_nodes: Array[QuestDialogueNode] = []

	var evaluated_dialogue_nodes: Array[QuestDialogueNode] = []

	for def in def_registry.values():

		var quest_data = get_quest_data(def.quest_id)

		if _is_valid_quest_source(entity_node, def):

			if !quest_data:
				
				if def.available_condition_set and !def.available_condition_set.evaluate():

					continue

				# Quest is not started but is available from this source

				quest_data = _create_quest_data(def.quest_id)

				set_quest_state(def.quest_id, QuestData.QuestState.AVAILABLE)

			if get_quest_state(def.quest_id) == QuestData.QuestState.AVAILABLE:

				unevaluated_dialogue_nodes.append(def.source_dialogue_node)

		elif quest_data:

			# Quest is started and this is not the source

			var current_stage = quest_data.get_stage()

			unevaluated_dialogue_nodes.append_array(current_stage.get_dialogue_nodes())
			
	for dialogue_node in unevaluated_dialogue_nodes:

		if dialogue_node.show_condition_set and !dialogue_node.show_condition_set.evaluate({"entity_node": entity_node}):

			continue

		evaluated_dialogue_nodes.append(dialogue_node)

	return evaluated_dialogue_nodes











func _is_valid_quest_source(entity_node: EntityNode, quest_def: QuestDef) -> bool:

	for source in quest_def.sources:

		if source.match(entity_node):

			return true

	return false




func _create_quest_data(quest_id: StringName) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest_id = quest_id

	quest_data.objective_completed.connect(_on_quest_objective_completed)

	quest_data.stage_completed.connect(_on_quest_stage_completed)

	quest_data.state_changed.connect(_on_quest_state_changed)

	var save_data = Game.get_save_data()

	save_data.quest_data_list.append(quest_data)

	return quest_data








func _on_quest_state_changed(quest_data: QuestData) -> void:

	match quest_data.state:

		QuestData.QuestState.READY:

			pass

		QuestData.QuestState.COMPLETE:

			Events.fire(QuestCompletedEvent, {"quest_data": quest_data})




func _on_quest_objective_completed(quest_data: QuestData, objective: QuestObjective) -> void:

	Events.fire(QuestObjectiveCompletedEvent, {"quest_data": quest_data, "objective": objective})



func _on_quest_stage_completed(quest_data: QuestData, stage: QuestStage) -> void:

	Events.fire(QuestStageCompletedEvent, {"quest_data": quest_data, "stage": stage})





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