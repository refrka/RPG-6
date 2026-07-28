class_name QuestData extends Resource



signal stage_changed(quest_data: QuestData)

signal state_changed(quest_data: QuestData, previous_state: QuestState)

signal objective_completed(quest_data: QuestData, objective: QuestObjective)

signal stage_completed(quest_data: QuestData, completed_index: int)



enum QuestState {

	UNKNOWN,

	AVAILABLE,

	ACTIVE,

	READY,

	COMPLETE

}



var quest_def: QuestDef

var state:= QuestState.AVAILABLE

var stage_index:= -1

var current_stage: QuestStage

var completed_objectives: Dictionary[int, Array]








func initialize() -> void:

	set_stage(0)





func get_stage(index:= -1) -> QuestStage:

	if index == -1:

		index = stage_index

	if _is_index_valid(stage_index):

		return quest_def.stages[stage_index]

	return null




func get_state() -> QuestState:

	return state




func get_quest_def() -> QuestDef:

	return quest_def



func get_quest_id() -> StringName:

	return quest_def.quest_id





func set_stage(index: int) -> void:

	if stage_index == -1 and index == 0:

		set_state(QuestState.ACTIVE)

	stage_index = index

	if _is_index_valid(stage_index):

		current_stage = quest_def.stages[stage_index]

		current_stage.objective_completed.connect(_on_objective_completed)

		current_stage.stage_completed.connect(_on_stage_completed)

		current_stage.initialize()

		stage_changed.emit(self)

	else:

		current_stage = null

		set_state(QuestState.COMPLETE)





func set_state(new_state: QuestState) -> void:

	var old_state = state

	state = new_state

	match state:

		QuestState.ACTIVE:

			Events.fire(QuestStateChangedEvent, {"quest_data": self, "old_state": old_state}, true)

		QuestState.COMPLETE:

			completed_objectives.clear()

			Events.fire(QuestStateChangedEvent, {"quest_data": self, "old_state": old_state}, true)

	state_changed.emit(self, old_state)





func complete_objective(objective: QuestObjective) -> void:

	if !completed_objectives.has(stage_index):

		completed_objectives[stage_index] = []

	completed_objectives[stage_index].append(current_stage.get_objective_index(objective))

	objective._complete()

	objective_completed.emit(self, objective)

	Events.fire(QuestObjectiveCompletedEvent, {"quest_data": self, "quest_objective": objective}, true)





func complete_stage() -> void:

	var completed_index = stage_index

	var next_index = stage_index + 1

	set_stage(next_index)

	stage_completed.emit(self, completed_index)

	

	



func get_stage_objectives(index:= -1) -> Array[QuestObjective]:

	var objectives: Array[QuestObjective] = []

	if index == -1:

		index = stage_index

	if quest_def.stages.size() - 1 <= index:

		objectives.assign(quest_def.stages[index].objectives)

	return objectives




func get_title() -> String:

	return quest_def.title









func _is_index_valid(index: int) -> bool:

	if !quest_def:

		return false

	return quest_def.stages.size() - 1 >= index and index != -1





func _is_stage_complete(index:= -1) -> bool:

	if index == -1:

		index = stage_index

	if !_is_index_valid(index):
		
		return false

	var stage = quest_def.stages[index]

	var complete = true

	for i in range(stage.objectives.size()):

		if !completed_objectives.has(i):

			complete = false

	return complete






func _on_objective_completed(objective: QuestObjective) -> void:

	complete_objective(objective)



func _on_stage_completed() -> void:

	complete_stage()





func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["quest_id"] = quest_def.quest_id

	save_dict["state"] = state

	save_dict["stage_index"] = stage_index

	save_dict["completed_objectives"] = completed_objectives

	return save_dict




static func load_dictionary(save_dict: Dictionary) -> QuestData:

	var quest_data = QuestData.new()

	var _quest_def = Quests.get_quest_def(save_dict["quest_id"])

	quest_data.quest_def = _quest_def

	quest_data.state = save_dict["state"] as QuestState

	for _stage_index in save_dict["completed_objectives"]:

		var objective_index_list = save_dict["completed_objectives"][_stage_index]

		var int_index_list: Array[int] = []

		for objective_index in objective_index_list:

			int_index_list.append(int(objective_index))

		quest_data.completed_objectives[int(_stage_index)] = int_index_list

	quest_data.stage_index = int(save_dict["stage_index"])
	
	quest_data.current_stage = quest_data.get_stage()

	if quest_data.current_stage:

		if quest_data.completed_objectives.has(quest_data.stage_index):

			for objective_index in quest_data.completed_objectives[quest_data.stage_index]:

				var objective = quest_data.current_stage.objectives[objective_index]

				quest_data.current_stage.completed_objectives.append(objective)

		quest_data.current_stage.objective_completed.connect(quest_data._on_objective_completed)

		quest_data.current_stage.stage_completed.connect(quest_data._on_stage_completed)

		quest_data.current_stage.initialize()

	return quest_data