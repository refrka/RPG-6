class_name DialogueNode extends Resource






@export_multiline var option_text: String

@export var dialogue_text: DialogueText

@export var options: Array[DialogueNode]

@export var show_condition_set: ConditionSet

@export var enter_condition_command_set: ConditionCommandSet

@export var exit_condition_command_set: ConditionCommandSet

@export var forced_greeting: Greeting




func _enter() -> void:

	if enter_condition_command_set:

		enter_condition_command_set.run({"dialogue_node": self})






func _exit() -> void:

	if exit_condition_command_set:

		exit_condition_command_set.run({"dialogue_node": self})