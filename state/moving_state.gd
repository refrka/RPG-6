class_name MovingState extends State


var moving_blend: AnimationNodeBlendSpace2D

var blend_node_names:= [

	"move_down_right",	# 0 Center

	"move_down_left",	# 1 Left

	"move_down_right",	# 2 Up

	"move_down_right",	# 3 Right

	"move_up_right",	# 4 Bottom

	"move_up_left",		# 5 Bottom-Left

	"move_down_left",	# 6 Upper-left

	"move_down_right",	# 7 Upper-right

	"move_up_right",	# 8 Bottom-right

]

var movement_component: MovementComponent

var default_playback: AnimationNodeStateMachinePlayback



func _setup(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.move_stopped.connect(_on_move_stopped)

	var root_state = animation_component.anim_tree.tree_root.get_node("RootState")

	var default_state = root_state.get_node("DefaultState")

	var moving_state = default_state.get_node("MovingTree")

	moving_blend = moving_state.get_node("MovingBlend")

	var library_name = entity.get_entity_id()

	for i in range(blend_node_names.size()):

		var blend_node_name = "%s/%s" % [library_name, blend_node_names[i]]

		blend_node_names[i] = blend_node_name

		var animation_node_animation = moving_blend.get_blend_point_node(i)

		animation_node_animation.animation = blend_node_name

	default_playback = animation_component.get_state_playback("default")





func _enter() -> void:

	default_playback.travel("MovingTree")





func _on_move_stopped() -> void:
	
	var root_state = animation_component.anim_tree.tree_root.get_node("RootState")

	var default_state = root_state.get_node("DefaultState")

	var moving_state = default_state.get_node("MovingTree")

	moving_blend = moving_state.get_node("MovingBlend")

	var animation_node_animation = moving_blend.get_blend_point_node(0)

	print(animation_node_animation.animation)

	entity.state_machine.request_state(IdleState)

