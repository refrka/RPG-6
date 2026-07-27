class_name TriggerSet extends Resource


@export var triggers: Array[Trigger]



func initialize() -> void:

	for trigger in triggers:

		trigger._initialize()