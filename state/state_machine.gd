class_name StateMachine extends Node



signal state_changed(new_state: State)







@export var initial_state: State


var entity: EntityNode

var current_state: State





func setup(_entity: EntityNode) -> void:

	entity = _entity

	for state in get_children():

		state._setup(_entity)

	if initial_state:

		_change_state(initial_state)





func request_state(state_script: Script, reenter:= false) -> void:

	var new_state = get_state(state_script)

	if !new_state:

		return

	_change_state(new_state)

	if reenter:

		new_state._enter()




func request_state_index(index: int) -> void:

	var new_state = get_child_state(index)

	if new_state:

		_change_state(new_state)





func get_current_state() -> State:

	return current_state



func get_state(state_script: Script) -> State:

	for state in get_children():

		if state.get_state_script() == state_script:

			return state

	return null



func get_child_state(index: int) -> State:

	if get_children().size() - 1 < index:

		return null

	return get_child(index)




func _change_state(new_state: State) -> void:

	if new_state == current_state and current_state.allow_reenter:

		current_state._enter()

		return

	elif current_state:

		current_state._exit()

	current_state = new_state

	current_state._enter()
		
	state_changed.emit()







func _process(delta: float) -> void:

	if current_state:

		current_state._tick(delta)