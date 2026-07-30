class_name State extends Node







var entity: EntityNode

var animation_component: AnimationComponent




func _setup(_entity: EntityNode) -> void:

	entity = _entity
		
	animation_component = entity.get_component(AnimationComponent)













func get_state_script() -> Script:

	return get_script()




func _enter() -> void:

	pass


func _exit() -> void:

	pass



func _tick(_delta: float) -> void:

	pass