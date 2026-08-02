class_name BehaviorComponent extends Component





var behavior_profile: BehaviorProfile

var active_behavior: Behavior

var valid_behaviors: Array[Behavior]



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var entity_def = entity.get_entity_def()

	if entity_def.behavior_profile:

		behavior_profile = entity_def.behavior_profile.duplicate_deep()

	if !behavior_profile:

		_deactivate()

		return

	for behavior in behavior_profile.behaviors:

		behavior._initialize(entity)









func evaluate_and_choose(data:= {}) -> void:

	var new_behavior = _choose_behavior(data)

	_start_behavior(new_behavior)







func _choose_behavior(data: Dictionary) -> Behavior:

	var priority_behavior:= active_behavior

	valid_behaviors.clear()

	for behavior in behavior_profile.behaviors:

		if behavior._evaluate(data):

			valid_behaviors.append(behavior)

			if !priority_behavior:

				priority_behavior = behavior

			else:

				if behavior.priority < priority_behavior.priority:

					continue
				
				elif behavior.priority == priority_behavior.priority:

					if behavior._evaluate_priority(priority_behavior):

						priority_behavior = behavior

				else:

					priority_behavior = behavior

	return priority_behavior








func _start_behavior(new_behavior: Behavior) -> void:

	if active_behavior:

		active_behavior._end()

	active_behavior = new_behavior

	active_behavior._start()






func _activate() -> void:

	if !behavior_profile:

		return

	super()

	if active_behavior:

		_start_behavior(active_behavior)
		
	else:

		_start_behavior(_choose_behavior({}))






func _process(delta: float) -> void:

	if !active:

		return

	if active_behavior:

		active_behavior._tick(delta)