class_name AnimationComponent extends Component



signal playback_state_changed(playback: AnimationNodeStateMachinePlayback)

signal root_state_changed(playback: AnimationNodeStateMachinePlayback)



@export var anim_player: AnimationPlayer

@export var anim_tree: AnimationTree


var playback_registry: Dictionary[StringName, AnimationNodeStateMachinePlayback]

var blend_space_registry: Dictionary[StringName, String]




func _ready() -> void: 
	
	process_mode = Node.PROCESS_MODE_DISABLED




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	anim_tree.tree_root = anim_tree.tree_root.duplicate_deep()

	playback_registry["root"] = anim_tree.get("parameters/RootState/playback")

	playback_registry["default"] = anim_tree.get("parameters/RootState/DefaultState/playback")

	playback_registry["combat"] = anim_tree.get("parameters/RootState/CombatState/playback")

	playback_registry["ready"] = anim_tree.get("parameters/RootState/CombatState/CombatReadyTree/ReadyState/playback")

	playback_registry["attack"] = anim_tree.get("parameters/RootState/CombatState/CombatAttackState/AttackTree/AttackState/playback")

	for playback_name in playback_registry:

		var playback = playback_registry[playback_name]

		if !playback:

			continue

		if playback_name == "root":

			playback.state_started.connect(_on_root_state_started.bind(playback))

		else:

			playback.state_started.connect(_on_playback_state_started.bind(playback))



	blend_space_registry["idle"] = "parameters/RootState/DefaultState/IdleTree/IdleBlend/blend_position"

	blend_space_registry["moving"] = "parameters/RootState/DefaultState/MovingTree/MovingBlend/blend_position"

	blend_space_registry["attack"] = "parameters/RootState/CombatState/CombatAttackState/AttackTree/AttackBlend/IdleBlend/blend_position"

	blend_space_registry["ready_idle"] = "parameters/RootState/CombatState/CombatReadyTree/ReadyState/IdleBlend/blend_position"

	blend_space_registry["ready_move"] = "parameters/RootState/CombatState/CombatReadyTree/ReadyState/MoveBlend/blend_position"

	blend_space_registry["attack_idle"] = "parameters/RootState/CombatState/CombatAttackState/AttackTree/AttackState/IdleBlend/blend_position"

	blend_space_registry["attack_move"] = "parameters/RootState/CombatState/CombatAttackState/AttackTree/AttackState/MoveBlend/blend_position"

	blend_space_registry["end_attack"] = "parameters/RootState/CombatState/EndAttackTree/EndAttackTree/IdleBlend/blend_position"

	blend_space_registry["charge"] = "parameters/RootState/CombatState/CombatChargeState/ChargeTree/ChargeBlend/playback"

	blend_space_registry["flinch"] = "parameters/FlinchBlend/FlinchBlend/blend_position"

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_updated)





func load_weapon_library(item_id: StringName) -> void:

	var library = load("res://animation/libraries/weapons/%s.res" % item_id)

	if !anim_tree.has_animation_library(item_id):

		anim_tree.add_animation_library(item_id, library)





func travel_playback(playback_name: StringName, node_name: String) -> void:

	var playback = get_state_playback(playback_name)

	playback.travel(node_name)



func start_playback(playback_name: StringName, node_name: String) -> void:

	var playback = get_state_playback(playback_name)

	playback.start(node_name)



func get_playback_node(playback_name: StringName) -> String:

	var playback = get_state_playback(playback_name)

	return playback.get_current_node()





func set_blend_space_vector(space_name: String, vector: Vector2) -> void:

	anim_tree.set(blend_space_registry[space_name], vector)



func set_all_blend_space_vectors(vector: Vector2) -> void:

	for blend_space_path in blend_space_registry.values():

		anim_tree.set(blend_space_path, vector)



func get_state_playback(playback_name: String) -> AnimationNodeStateMachinePlayback:

	return playback_registry[playback_name]




func _on_root_state_started(_state_name: String, playback: AnimationNodeStateMachinePlayback) -> void:

	root_state_changed.emit(playback)



func _on_playback_state_started(_state_name: String, playback: AnimationNodeStateMachinePlayback) -> void:

	playback_state_changed.emit(playback)



func _on_face_dir_updated(dir: Vector2) -> void:

	for blend_space_name in blend_space_registry:

		set_blend_space_vector(blend_space_name, dir)

