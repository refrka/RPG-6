class_name ConditionSet extends Resource



@export var conditions: Array[Condition]

var data: Dictionary




func evaluate(_data: Dictionary = {}) -> bool:

	data = _data

	for condition in conditions:

		if !condition.evaluate(data):

			return false

	return true