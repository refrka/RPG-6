class_name DialogueNode extends Resource




@export_multiline var option_text: String

@export var dialogue_text: DialogueText

@export var forced_greeting: DialogueText

@export var option_nodes: Array[DialogueNode]

@export var show_condition_set: ConditionSet



@export var enter_conditional: ConditionalCommandSet

@export var exit_conditional: ConditionalCommandSet









func enter() -> void:

	if enter_conditional:

		enter_conditional.execute_commands()




func exit() -> void:

	if exit_conditional:

		exit_conditional.execute_commands()