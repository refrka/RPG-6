class_name CombatComponent extends Component



signal entity_hit(entity_node: EntityNode, damage_package: DamagePackage)

signal target_changed(new_target: EntityNode)


@export var combat_root: Node2D

@export var combat_hitbox: Hitbox





var animation_component: AnimationComponent

var movement_component: MovementComponent

var attack_animation_node: AnimationNodeAnimation





var current_attack_config: AttackConfig

var current_attack_def: AttackDef

var current_attack_index:= 0

var current_attack_dir: Vector2

var current_library_name: String

var current_animation_name: String



var target_entity: EntityNode




var attack_held:= false

var attack_buffered:= false

var buffer_window_open:= false

var buffered_attack_dir: Vector2









func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_hitbox.setup(entity)

	combat_hitbox.hit_detected.connect(_on_hit_detected)

	entity.inventory.inventory_loaded.connect(_on_inventory_loaded)

	entity.inventory.item_equipped.connect(_on_item_equipped)

	entity.inventory.item_unequipped.connect(_on_item_unequipped)

	movement_component = entity.get_component(MovementComponent)

	animation_component = entity.get_component(AnimationComponent)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_released)

	var root_state = animation_component.anim_tree.tree_root.get_node("RootState")

	var combat_state = root_state.get_node("CombatState")

	var combat_attack_state = combat_state.get_node("CombatAttackState")

	var attack_tree = combat_attack_state.get_node("AttackTree")

	attack_animation_node = attack_tree.get_node("AttackAnimation")

	var ready_state = entity.state_machine.get_state(CombatReadyState)

	ready_state.ready_timeout.connect(_on_ready_timeout)

	if entity.get_entity_def().melee_attack_config:

		_set_attack_data(entity.get_entity_def().melee_attack_config)

		current_library_name = entity.get_entity_id()






func attack(_target_entity: EntityNode) -> void:

	if !_is_in_combat():
		
		_enter_combat()

	if !_is_attacking():

		_set_target_entity(_target_entity)

		_try_attack()





func open_buffer_window() -> void:

	buffer_window_open = true


func close_buffer_window() -> void:

	buffer_window_open = false



func _handle_weapon_attack_input() -> void:

	if !_is_attacking():
	
		_try_attack()

	elif buffer_window_open:

		_try_buffer_attack()











func _enter_combat() -> void:

	_enter_combat_ready()

	if entity is PlayerNode:

		Events.fire(PlayerEnteredCombatEvent)




func _exit_combat() -> void:

	entity.state_machine.request_state(IdleState)

	if entity is PlayerNode:

		Events.fire(PlayerExitedCombatEvent)



func _enter_combat_ready() -> void:

	entity.state_machine.request_state(CombatReadyState)








func _try_attack() -> void:

	if !_can_attack():

		return

	_start_attack()




func _start_attack(buffered:= false) -> void:

	if !_is_index_valid(current_attack_index):

		return

	if !_is_in_combat():

		_enter_combat()

	if !_has_valid_attack_data():

		_finish_attack()

		return

	var attack_entry = _get_attack_entry(current_attack_index)

	if !attack_entry:

		_finish_attack()

		return

	var attack_dir:= _get_attack_direction()

	if buffered:

		attack_dir = buffered_attack_dir

	_set_attack_dir(attack_dir)

	_execute_attack()

	



func _execute_attack() -> void:

	current_animation_name = _get_attack_animation_name()

	attack_animation_node.animation = current_animation_name

	entity.state_machine.request_state(CombatAttackingState)

	var move_penalty = _get_attack_entry().move_penalty	

	var move_speed = entity.get_entity_def().move_speed

	movement_component.set_move_speed_override(move_speed * (1.0 - move_penalty))

	



func _finish_attack() -> void:

	movement_component.remove_move_speed_override()

	close_buffer_window()

	if attack_buffered:

		current_attack_index += 1

		attack_buffered = false

		_start_attack(true)

	_reset_attack_data()

	_enter_combat_ready()





func _try_buffer_attack() -> void:

	var next_index = current_attack_index + 1

	if _is_index_valid(next_index):

		attack_buffered = true

		buffered_attack_dir = _get_attack_direction()











func _reset_attack_data() -> void:

	current_attack_index = 0

	current_attack_dir = Vector2.ZERO

	current_animation_name = ""



func _clear_attack_data() -> void:

	current_attack_config = null
	
	current_attack_def = null

	current_library_name = ""

	_reset_attack_data()








func _set_target_entity(entity_node: EntityNode) -> void:

	target_entity = entity_node

	target_changed.emit(entity_node)




func _set_attack_data(attack_config: AttackConfig) -> void:

	_set_attack_config(attack_config)



func _set_weapon_attack_data(weapon_def: WeaponDef) -> void:

	_set_attack_config(weapon_def.default_attack_config)

	current_library_name = weapon_def.item_id

	animation_component.load_weapon_library(weapon_def.item_id)




func _set_attack_dir(target_dir: Vector2) -> void:

	current_attack_dir = target_dir

	combat_root.rotation = Vector2.RIGHT.angle_to(target_dir)

	



func _set_attack_config(attack_config: AttackConfig) -> void:

	current_attack_config = attack_config

	_set_attack_def(current_attack_config.default_attack_def)



func _set_attack_def(attack_def: AttackDef) -> void:

	current_attack_def = attack_def



func _set_attack_index(index: int) -> void:

	current_attack_index = index








func _get_attack_direction() -> Vector2:

	if entity is PlayerNode:

		return Game.get_mouse_direction()

	if target_entity:

		return entity.global_position.direction_to(target_entity.global_position)

	return Vector2.ZERO



func _get_attack_entry(index: int = -1) -> AttackEntry:

	if index == -1:

		index = current_attack_index

	if !_has_valid_attack_data():

		return null

	return current_attack_def.attack_set[index]



func _get_attack_animation_name(index:= -1) -> StringName:

	if index == -1:

		index = current_attack_index

	return "%s/default_%s" % [current_library_name, index]




func _get_damage_package() -> DamagePackage:

	var attack_entry = _get_attack_entry(current_attack_index)

	var damage_package = DamagePackage.generate_package(entity, attack_entry)

	return damage_package








func _is_attacking() -> bool:

	return entity.state_machine.get_current_state() is CombatAttackingState



func _is_in_combat() -> bool:

	return entity.state_machine.get_current_state() is CombatState



func _is_index_valid(index:= -1) -> bool:

	if index == -1:

		index = current_attack_index

	if !current_attack_def:

		return false

	if index > current_attack_def.attack_set.size() - 1:

		return false

	if !animation_component.anim_tree.has_animation(_get_attack_animation_name(index)):

		return false

	return true


func _can_attack() -> bool:

	if entity.state_machine.get_current_state() is BusyState:

		return false

	return true







func _has_valid_attack_data() -> bool:

	var valid = true

	if !current_attack_config or !current_attack_def or current_attack_def.attack_set.is_empty():

		valid = false

	return valid








func _on_weapon_attack_input_pressed() -> void:

	_handle_weapon_attack_input()




func _on_weapon_attack_input_released() -> void:

	pass



func _on_item_equipped(item_data: ItemData) -> void:

	var item_def = item_data.get_item_def()

	if item_def is WeaponDef:

		_set_weapon_attack_data(item_def)




func _on_item_unequipped(item_data: ItemData) -> void:

	var item_def = item_data.get_item_def()

	if item_def is WeaponDef:

		_clear_attack_data()



func _on_inventory_loaded() -> void:

	var weapon_data = entity.inventory.get_equipment(EquipmentDef.EquipmentType.WEAPON)

	if weapon_data:

		var item_def = weapon_data.get_item_def() as WeaponDef

		_set_weapon_attack_data(item_def)

	elif entity.get_entity_def().melee_attack_config:

		_set_attack_data(entity.get_entity_def().melee_attack_config)

		current_library_name = entity.get_entity_id()

	




func _on_ready_timeout() -> void:

	_exit_combat()




func _on_hit_detected(_target_entity: EntityNode) -> void:

	var damage_package = _get_damage_package()

	if _target_entity.accept_hit(damage_package):

		entity_hit.emit(_target_entity, damage_package)