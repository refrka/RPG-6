class_name Behavior extends Resource






enum BehaviorType {

	AMBIENT,

	CONFLICT,

	PRESERVATION,

	SOCIAL,

}


@export var behavior_type: BehaviorType

@export_range(1.0, 10.0, 1.0) var priority:= 1.0

@export var condition_set: ConditionSet



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