class_name ConditionCommandSet extends Resource



@export var condition_set: ConditionSet

@export var command_set: CommandSet







func run(data: Dictionary = {}) -> void:

	var passed = true

	if !condition_set.evaluate(data):

		passed = false

	if passed:

		command_set.execute(data)