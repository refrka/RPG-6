class_name DialogueNode extends Resource




@export_multiline var option_text: String

@export var dialogue_text: DialogueText

@export var option_nodes: Array[DialogueNode]

@export var show_condition_set: ConditionSet



@export var enter_conditional: ConditionalCommandSet

@export var exit_conditional: ConditionalCommandSet






func enter() -> void:

	enter_conditional.execute_commands()




func exit() -> void:

	exit_conditional.execute_commands()