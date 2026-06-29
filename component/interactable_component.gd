class_name InteractableComponent extends Component



enum InteractionType {

	INSTANT,

	TOGGLE,

	HOLD,

}

@export var type: InteractionType

@export var duration:= 0.0











func interact() -> bool:

	UI.open_dialogue(entity)

	return true





func complete() -> void:

	end()



func end() -> void:
	
	UI.close_dialogue()

