class_name AnimationComponent extends Component



@export var anim_player: AnimationPlayer

@export var anim_tree: AnimationTree


var playback_registry: Dictionary[StringName, AnimationNodeStateMachinePlayback]

var blend_space_registry: Dictionary[StringName, String]




func _ready() -> void: 
	
	process_mode = Node.PROCESS_MODE_DISABLED

	anim_tree.tree_root = anim_tree.tree_root.duplicate_deep()




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	playback_registry["root"] = anim_tree.get("parameters/RootState/playback")

	playback_registry["default"] = anim_tree.get("parameters/RootState/DefaultState/playback")

	playback_registry["combat"] = anim_tree.get("parameters/RootState/CombatState/playback")


	blend_space_registry["idle"] = "parameters/RootState/DefaultState/IdleTree/IdleBlend/blend_position"

	blend_space_registry["moving"] = "parameters/RootState/DefaultState/MovingTree/MovingBlend/blend_position"






func load_weapon_library(item_id: StringName) -> void:

	var library = load("res://animation/libraries/weapons/%s.res" % item_id)

	if !anim_tree.has_animation_library(item_id):

		anim_tree.add_animation_library(item_id, library)






func set_blend_space_vector(space_name: String, vector: Vector2) -> void:

	anim_tree.set(blend_space_registry[space_name], vector)





func get_state_playback(playback_name: String) -> AnimationNodeStateMachinePlayback:

	return playback_registry[playback_name]




