class_name StateMachine extends Node



signal state_changed(new_state: State)







@export var initial_state: State

var current_state: State






func setup(_entity: EntityNode) -> void:

	for state in get_children():

		state._setup(_entity)

	if initial_state:

		_change_state(initial_state)






func request_state(state_name: StringName) -> void:

	var new_state = get_state(state_name)

	if !new_state:

		return

	_change_state(new_state)




func get_current_state() -> State:

	return current_state



func get_state(state_name: String) -> State:

	for state in get_children():

		if state.get_state_name() == state_name:

			return state

	return null








func _change_state(new_state: State) -> void:

	if new_state == current_state:

		current_state._enter()

		return

	else:

		new_state._exit()

	current_state = new_state

	current_state._enter()
		
	state_changed.emit()





func _process(delta: float) -> void:

	if current_state:

		current_state._tick(delta)
