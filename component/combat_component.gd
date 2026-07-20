class_name CombatComponent extends Component



var input_component: InputComponent

var animation_component: AnimationComponent







var current_attack_config: AttackConfig

var current_attack_entry: AttackEntry

var attack_index:= 0





var buffer_window_open:= false

var buffered_attack:= false






func _setup(_entity: EntityNode) -> void:

	super(_entity)

	input_component = entity.get_component(InputComponent)

	animation_component = entity.get_component(AnimationComponent)







func set_buffer_state(state: bool) -> void:

	buffer_window_open = state



func get_attack_animation_name() -> StringName:

	return &"attack_%s" % attack_index







func _handle_weapon_attack_input() -> void:

	if _is_attacking():

		_buffer_attack()

	else:

		_try_attack()






func _try_attack() -> void:

	pass






func _end_attack() -> void:

	if buffered_attack:

		attack_index += 1

		_try_attack()

	else:

		_clear_attack_data()






func _buffer_attack() -> void:

	if !buffer_window_open:

		return

	if buffered_attack:

		return

	var desired_index = attack_index + 1

	if _is_index_valid(desired_index):

		buffered_attack = true







func _is_attacking() -> bool:

	return entity.state_machine.get_current_state() is CombatAttackState





func _is_index_valid(index: int) -> bool:

	if !current_attack_config:

		return false

	if current_attack_config.attack_set.size() - 1 < index:

		return false

	return true





func _clear_attack_data() -> void:

	attack_index = 0

	current_attack_config = null

	current_attack_entry = null

	buffer_window_open = false

	buffered_attack = false






func _activate() -> void:

	super()

	_connect_weapon_attack_input()




func _deactivate() -> void:

	super()

	_disconnect_weapon_attack_input()












func _connect_weapon_attack_input() -> void:

	if input_component:

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_released.connect(_on_weapon_attack_input_released)


func _disconnect_weapon_attack_input() -> void:

	if input_component:

		input_component.weapon_attack_pressed.disconnect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_released.disconnect(_on_weapon_attack_input_released)










func _on_weapon_attack_input_pressed() -> void:

	_handle_weapon_attack_input()



func _on_weapon_attack_input_released() -> void:

	pass