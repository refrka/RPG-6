class_name State extends Node




@export var allow_reenter:= false


var active:= false

var entity: EntityNode

var animation_component: AnimationComponent




func _setup(_entity: EntityNode) -> void:

	entity = _entity
		
	animation_component = entity.get_component(AnimationComponent)













func get_state_script() -> Script:

	return get_script()




func _enter() -> void:

	active = true




func _exit() -> void:

	active = false




func _tick(_delta: float) -> void:

	pass