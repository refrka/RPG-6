class_name ProfileQuestStageInfo extends MarginContainer




@export var stage_num_label: Label

@export var objective_list: VBoxContainer

var quest_data: QuestData

var stage_index: int




func _ready() -> void:

	for child in objective_list.get_children():

		child.queue_free()




func load_stage_info(_quest_data: QuestData, _stage_index: int) -> void:

	quest_data = _quest_data

	stage_index = _stage_index

	var stage = quest_data.get_stage(stage_index)

	stage_num_label.text = "Stage %s" % stage_index

	for objective in stage.objectives:

		add_objective_text(objective)










func add_objective_text(objective: QuestObjective) -> void:

	var text = objective.description

	var i = objective_list.get_children().size() + 1

	text = "%s. %s" % [i, text]

	var label = Label.new()

	label.text = text

	objective_list.add_child(label)