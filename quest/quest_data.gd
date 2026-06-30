class_name QuestData extends Resource


signal state_changed(quest_data: QuestData)

signal completed(quest_data: QuestData)


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

	if _is_quest_ready():

		set_state(QuestState.READY)

		return

	var new_stage = get_def().stages[stage_index]

	new_stage.objective_completed.connect(_on_objective_completed)

	new_stage._initialize()









func get_def() -> QuestDef:

	return Quests.get_quest_def(quest_id)











func _is_quest_ready() -> bool:

	if stage_index > get_def().stages.size() - 1:

		return true

	return false




func _is_stage_complete() -> bool:

	if _is_quest_ready():

		return true

	var stage = get_def().stages[stage_index]

	for objective in stage.objectives:

		if !completed_stage_objectives.has(objective):

			return false

	return true








func _on_objective_completed(objective: QuestObjective, stage: QuestStage) -> void:

	if completed_stage_objectives.has(objective):

		return

	completed_stage_objectives.append(objective)

	if _is_stage_complete():

		stage.objective_completed.disconnect(_on_objective_completed)

		set_stage(stage_index + 1)






func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["quest_id"] = quest_id

	save_dict["state"] = state

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest_id = save_dict["quest_id"]

	quest_data.state = int(save_dict["state"]) as QuestState

	return quest_data



