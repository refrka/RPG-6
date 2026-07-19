class_name QuestDialogueNode extends DialogueNode


@export var related_quest_id: StringName

@export var related_quest_def: QuestDef


var assigned_quest_id: StringName



func _enter() -> void:

	if assigned_quest_id != &"":

		related_quest_id = assigned_quest_id

	if !related_quest_def:

		related_quest_def = Quests.get_quest_def(related_quest_id)

	if enter_condition_command_set:

		enter_condition_command_set.run_set({"dialogue_node": self, "quest_def": related_quest_def})




func _exit() -> void:

	print("exit the node")

	if assigned_quest_id != &"":

		related_quest_id = assigned_quest_id

	if !related_quest_def:

		related_quest_def = Quests.get_quest_def(related_quest_id)

	if exit_condition_command_set:

		exit_condition_command_set.run_set({"dialogue_node": self, "quest_def": related_quest_def})







func assign_quest_id(_quest_id: StringName) -> void:

	assigned_quest_id = _quest_id