class_name State extends Node




@export var allow_reenter:= false


var entity: EntityNode

var animation_component: AnimationComponent

var root_playback: AnimationNodeStateMachinePlayback




func _setup(_entity: EntityNode) -> void:

	entity = _entity
		
	animation_component = entity.get_component(AnimationComponent)

	root_playback = animation_component.get_state_playback("root")













func get_state_script() -> Script:

	return get_script()




func _enter() -> void:

	pass


func _exit() -> void:

	pass



func _tick(_delta: float) -> void:

	pass