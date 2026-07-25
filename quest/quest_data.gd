class_name QuestData extends Resource


signal stage_changed(quest_data: QuestData)

signal objective_completed(quest_data: QuestData, objective: QuestObjective)


var quest_def: QuestDef

var stage_index: int

var current_stage: QuestStage

var completed_objectives: Array[QuestObjective]








func initialize() -> void:

	set_stage(0)






func set_stage(index: int) -> void:

	if stage_index == -1 and index == 0:

		Events.fire(QuestStartedEvent, {"quest_data": self})

	stage_index = index

	if _is_index_valid(stage_index):

		current_stage = quest_def.stages[stage_index]

		current_stage.initialize()

		stage_changed.emit(self)






func complete_objective(objective: QuestObjective) -> void:

	completed_objectives.append(objective)

	objective_completed.emit(self, objective)





func get_stage_objectives(index:= -1) -> Array[QuestObjective]:

	var objectives: Array[QuestObjective] = []

	if index == -1:

		index = stage_index

	if quest_def.stages.size() - 1 <= index:

		objectives.assign(quest_def.stages[index].objectives)

	return objectives

	




func _is_index_valid(index: int) -> bool:

	if !quest_def:

		return false

	return quest_def.stages.size() - 1 <= index





func _is_stage_complete(index:= -1) -> bool:

	if index == -1:

		index = stage_index

	if !_is_index_valid(index):
		
		return false

	var stage = quest_def.stages[index]

	var complete = true

	for objective in stage.objectives:

		if !completed_objectives.has(objective):

			complete = false

	return complete