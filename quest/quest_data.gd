class_name QuestData extends Resource


enum QuestState {

	AVAILABLE,

	ACTIVE,

	READY,

	COMPLETE,

}

var quest_id: StringName

var state: QuestState









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