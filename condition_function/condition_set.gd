class_name ConditionSet extends Resource





@export var condition_functions: Array[ConditionFunction]







func evaluate(_data: Dictionary = {}) -> bool:

	var passed:= true

	for condition in condition_functions:

		if !condition.evaluate(_data):

			passed = false

			break
	
	return passed

