class_name ConditionalCommandSet extends Resource


@export var condition_set: ConditionSet

@export var command_set: CommandSet




func execute_commands(data:= {}) -> bool:

	if !condition_set or condition_set.evaluate(data):

		command_set.execute(data)

		return true
	
	return false