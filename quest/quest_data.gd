class_name QuestData extends Resource


enum QuestState {

	UNKNOWN,

	AVAILABLE,

	ACTIVE,

	READY,

	COMPLETE,

}

var quest_id: StringName

var state: QuestState




var source_entity: EntityNode

var state_condition_sets: Dictionary[QuestState, Array]




func set_state(new_state: QuestState) -> void:

	state = new_state

	if state == QuestState.COMPLETE:

		Events.fire(QuestCompletedEvent)




func can_set_state(new_state: QuestState) -> bool:

	var passed = true

	if !state_condition_sets.has(new_state):

		return passed

	var condition_sets = state_condition_sets[new_state]

	for condition_set in condition_sets:

		if !condition_set.evaluate():

			passed = false

			break

	return passed





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