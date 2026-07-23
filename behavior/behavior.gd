class_name Behavior extends Resource



enum Priority {

	NONE,

	TASK,

	SURVIVAL,

}



@export var condition_set: ConditionSet

@export var priority: Priority



var entity: EntityNode





func _initialize(_entity: EntityNode) -> void:

	entity = _entity




func _evaluate(_data:= {}) -> bool:

	return true




func _evaluate_priority(behavior: Behavior) -> bool:

	return priority > behavior.priority




func _start() -> void:
	
	pass




func _end() -> void:

	pass




func _tick(_delta: float) -> void:

	pass