class_name QuestData extends Resource


signal state_changed(quest_data: QuestData)

signal objective_completed(quest_data: QuestData, objective: QuestObjective)

signal stage_completed(quest_data: QuestData, stage: QuestStage)


enum QuestState {

	UNKNOWN,

	AVAILABLE,

	ACTIVE,

	READY,

	COMPLETE,

}

var quest_id: StringName

var state: QuestState

var stage_index:= 0

var completed_stage_objectives: Array[QuestObjective]

var source_entity: EntityNode







func set_state(new_state: QuestState) -> void:

	state = new_state

	state_changed.emit(self)






func set_stage(new_index: int) -> void:

	stage_index = new_index

	if is_quest_complete():

		return

	if is_quest_ready():

		set_state(QuestState.READY)

		return

	var new_stage = get_def().stages[stage_index]

	new_stage.objective_completed.connect(_on_objective_completed)

	new_stage._initialize()





func get_stage_dialogue_nodes() -> Array[DialogueNode]:

	var dialogue_nodes: Array[DialogueNode] = []

	var stage = get_stage()

	if stage:

		dialogue_nodes.append_array(stage.get_dialogue_nodes())

	return dialogue_nodes




func get_def() -> QuestDef:

	return Quests.get_quest_def(quest_id)





func get_stage(index:= -1) -> QuestStage:

	if index == -1:

		index = stage_index

	if is_quest_ready() or is_quest_complete():

		return null

	return get_def().stages[index]





func get_state() -> QuestState:

	return state







func is_quest_ready() -> bool:

	if stage_index > get_def().stages.size() - 1:

		return true

	return false




func is_objective_complete(objective: QuestObjective) -> bool:

	return completed_stage_objectives.has(objective)






func is_stage_complete() -> bool:

	if is_quest_ready():

		return true

	var stage = get_def().stages[stage_index]

	for objective in stage.objectives:

		if !completed_stage_objectives.has(objective):

			return false

	return true



func is_quest_complete() -> bool:

	return state == QuestState.COMPLETE and stage_index == -1




func _on_objective_completed(objective: QuestObjective, stage: QuestStage) -> void:

	if state != QuestState.ACTIVE:

		set_state(QuestData.QuestState.ACTIVE)

	if completed_stage_objectives.has(objective):

		return

	completed_stage_objectives.append(objective)

	objective_completed.emit(self, objective)

	if is_stage_complete():

		stage.objective_completed.disconnect(_on_objective_completed)

		set_stage(stage_index + 1)

		stage_completed.emit(self, stage)







func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["quest_id"] = quest_id

	save_dict["state"] = state

	save_dict["stage_index"] = stage_index

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest_id = save_dict["quest_id"]

	quest_data.state = int(save_dict["state"]) as QuestState

	quest_data.stage_index = int(save_dict["stage_index"])

	return quest_data


