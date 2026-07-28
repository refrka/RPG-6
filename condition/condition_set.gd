class_name ConditionSet extends Resource



@export var conditions: Array[Condition]

var data: Dictionary




func evaluate(_data: Dictionary = {}) -> bool:

	print("evaluating condition set with data: ", _data)

	data = _data

	for condition in conditions:

		print("checking condition: ", condition)

		if !condition.evaluate(data):

			print("false")

			return false

	return true