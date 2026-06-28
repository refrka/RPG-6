class_name InteractableComponent extends Component



enum InteractionType {

	INSTANT,

	TOGGLE,

	HOLD,

}

@export var type: InteractionType

@export var duration:= 0.0











func interact() -> bool:

	return false


func complete() -> void:

	pass