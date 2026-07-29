class_name CombatComponent extends Component




@export var combat_root: Node2D




var current_attack_config: AttackConfig

var current_attack_def: AttackDef

var current_attack_index:= -1



var attack_held:= false







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	entity.inventory.item_equipped.connect(_on_item_equipped)

	entity.inventory.item_unequipped.connect(_on_item_unequipped)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_released)














func _enter_combat() -> void:

	_enter_combat_ready()




func _exit_combat() -> void:

	entity.state_machine.request_state(IdleState)



func _enter_combat_ready() -> void:

	entity.state_machine.request_state(CombatReadyState)







func _can_attack() -> bool:

	return true




func _try_attack() -> void:

	print("trying attack")

	if !_can_attack():

		return

	_start_attack()




func _start_attack() -> void:

	current_attack_index = 0

	if !_is_in_combat():

		_enter_combat()

	if !_has_valid_attack_data():

		_finish_attack()

		return

	var attack_entry = _get_attack_entry(current_attack_index)

	if !attack_entry:

		_finish_attack()

		return

	_execute_attack()

	



func _execute_attack() -> void:

	print("executing attack")




func _finish_attack() -> void:

	print("finishing attack")

	_set_attack_index(-1)

	_enter_combat_ready()















func _rotate_to_mouse_position() -> void:

	_set_rotation(Game.get_mouse_position())
















func _clear_attack_data() -> void:

	current_attack_config = null
	
	current_attack_def = null

	current_attack_index = -1













func _set_rotation(target_pos: Vector2) -> void:

	combat_root.rotation = deg_to_rad(Vector2.RIGHT.angle_to(target_pos))



func _set_attack_config(attack_config: AttackConfig) -> void:

	current_attack_config = attack_config



func _set_attack_def(attack_def: AttackDef) -> void:

	current_attack_def = attack_def



func _set_attack_index(index: int) -> void:

	current_attack_index = index






func _get_attack_entry(index: int) -> AttackEntry:

	if !_has_valid_attack_data():

		return null

	return current_attack_def.attack_set[index]










func _is_attacking() -> bool:

	return entity.state_machine.get_current_state() is CombatAttackingState



func _is_in_combat() -> bool:

	return entity.state_machine.get_current_state() is CombatState



func _has_valid_attack_data() -> bool:

	var valid = true

	if !current_attack_config or !current_attack_def or current_attack_def.attack_set.is_empty():

		valid = false

	return valid








func _on_weapon_attack_input_pressed() -> void:

	_try_attack()



func _on_weapon_attack_input_released() -> void:

	pass



func _on_item_equipped(item_data: ItemData) -> void:

	var item_def = item_data.get_item_def()

	if item_def is WeaponDef:

		_set_attack_config(item_def.default_attack_config)

		_set_attack_def(current_attack_config.default_attack_def)



func _on_item_unequipped(item_data: ItemData) -> void:

	var item_def = item_data.get_item_def()

	if item_def is WeaponDef:

		_clear_attack_data()